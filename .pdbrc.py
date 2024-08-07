import pdb

import inspect

actual_precmd_source = inspect.getsource(pdb.Pdb.precmd)
# Store this source code string in pdb.Pdb object, so that it can be used later
# on by the monkeypatch functions.
pdb.Pdb._reserverd_actual_precmd_source = actual_precmd_source


def new_precmd(self, line, *args, **kwargs):
    # This function calls the original precmd function,
    # but also stores the `self.lastcmd` at the time of the call in a new member variable.
    # This new state end up being the last-last-command.

    # This function is monkeypatched in the most bizarre way.
    # Since this function ends up calling its own original implementation, we
    # cannot simply override it.
    # If we do, it becomes an infinite recursion.

    # So instead, we read the code of the original function in a string with
    # `inspect` package,
    # do some string manipulation to build a trampoline function's source code
    # and then execute that function.

    # These re-imports are required because otherwise falling into pdb with a
    # breakpoint() instruction does not see the top-of-file imports.
    import pdb
    original_source = pdb.Pdb._reserverd_actual_precmd_source

    ss = f"""
def trampoline_precmd(self, line, *args, **kwargs):
{original_source}

    # Store the last-last-command
    self._reserved_last_last_cmd = self.lastcmd
    return precmd(self, line, *args, **kwargs)
"""

    d = {}
    exec(ss, d)
    return d["trampoline_precmd"](self, line, *args, **kwargs)


def do_list_restore_lastcmd(self, arg):
    # A simple monkeypatch function to call the actual list function,
    # but without recording the execution in the self.lastcmd state.

    # At the end, it restores the lastcmd state to the actual previously
    # executed command that was specified by the user.

    # To do that, it uses the newly added _reserved_last_last_cmd state, which
    # is now maintained in the monkeypatched precmd function.
    self.do_list(arg)
    self.lastcmd = self._reserved_last_last_cmd


def new_emptyline(self):
    # This monkeypatch function handles the use case where the user merely
    # presses RET on an empty line to execute the previous command as is.
    # That is a pretty common use case in command line debuggers.

    # We only support the `next` command and whenever we encounter the next
    # command that is indirectly executed via an empty line and RET, we enqueue
    # a `list` command right after.

    # The `list` command we enqueue does not record itself in the self.lastcmd history,
    # so this becomes hidden from the user.
    # Hence the user can press RET again to execute the original `next` command again.

    # These re-imports are required because otherwise falling into pdb with a
    # breakpoint() instruction does not see the top-of-file imports.
    import pdb
    rv = super(pdb.Pdb, self).emptyline()

    # If the repeated command is next, then also print the context
    if self.lastcmd in ["next"]:
        self.cmdqueue.append("list_restore_lastcmd .")

    return rv


# Monkeypatch the functions, using the approach here https://stackoverflow.com/a/19546169/5771861
pdb.Pdb.precmd = new_precmd
pdb.Pdb.do_list_restore_lastcmd = do_list_restore_lastcmd
pdb.Pdb.emptyline = new_emptyline
