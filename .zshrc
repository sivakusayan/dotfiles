# ================================================================================
# ZSH SETUP
# ================================================================================

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/sayan/.zshrc'
autoload -Uz compinit
compinit

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="simplerich"
source "$HOME/Applications/simplerich-zsh-theme/zsh-git-prompt/zshrc.sh"
# Specific flag for the simplerich ZSH theme to stop querying Git all the time
export ZSH_THEME_GIT_PROMPT_CACHE=1

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

plugins=(
	git
	zsh-autosuggestions
	zsh-history-substring-search
)
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
source $ZSH/oh-my-zsh.sh
source $HOME/Applications/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# ================================================================================
# NON-ZSH SETUP
# ================================================================================

# Add Go binaries to Path
export PATH="$HOME/go/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin

# Add custom shell scripts for i3 startup
export PATH="$PATH:/home/sayan/.local/bin"

# Add Path for GNU grep and other related GNU tools
export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"

# Aliases
alias sed="sed -i"
# Rename alias to not conflict with `bb` utility during Chromium development
alias bbs=/opt/homebrew/bin/bb
alias bat="batcat"
alias grep="grep -n -P --color=always"
alias clang++="clang++ -std=c++20"
alias ls="eza -g --icons"
alias python="python3"
alias pdb="python3 -m pdb"
alias objdump="unbuffer objdump --disassembler-color=terminal --visualize-jumps=extended-color -M intel" 
