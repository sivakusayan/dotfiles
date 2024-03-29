export PATH="$PATH:/Users/sayansivakumaran/Development/depot_tools"
export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
export PUPPETEER_EXECUTABLE_PATH=`which chromium`
export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="$PATH:$( python3 -m site --user-base )/bin"
alias bb=/Users/sayansivakumaran/Development/depot_tools/bb
alias bbs=/opt/homebrew/bin/bb
alias grep="ggrep -n -P --color=always"
alias clang++="clang++ -std=c++20"
export ASAN_OPTIONS=abort_on_error=1:halt_on_error=1
export UBSAN_OPTIONS=abort_on_error=1:halt_on_error=1
export LSAN_OPTIONS=verbosity=1:log_threads=1
