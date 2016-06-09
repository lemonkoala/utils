export PS1="\e[35m\u@\h\e[m \e[0;33m\w\e[0m \$(parse_git_branch) \n\[\e[0;33m\]-->\[\e[0m\] "
export PS2="->"

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

export EDITOR=/usr/bin/vim
export PATH="$PATH:$HOME/bin"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
