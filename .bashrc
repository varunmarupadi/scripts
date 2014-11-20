# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[00;44m\]\D{%M:%S}\[\033[00;33m\] \u@\h\[\033[00;37m\] \w\[\033[00;34m\]$(__git_ps1 " [%s]")\[\033[00;37m\]\n#\[\033[00m\] '
  #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    TITLE="\[\e]0;$1\]"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    # WARNING: enabling this can cause multi-second delays due to NFS latency
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

alias e='emacsclient -nc'
alias enw='emacsclient -tc'
alias gtags="/home/build/nonconf/google3/tools/tags/gtags.sh"
alias prodaccess='prodaccess -g'
alias p='prodaccess -g'
alias ge='git5 export --sq --tap_project=datascape,plx_testing --tap_options=email,detach'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Modifies bash prompt to show git branch and dirty & stash state
# https://makandracards.com/makandra/524-show-the-current-git-branch-on-your-bash-prompt

# Stop glucid from taking too long to display prompts on home directories.
export GIT_CEILING_DIRECTORIES=/home

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWSTASHSTATE=true
export PS1='${debian_chroot:+($debian_chroot)}\[\033[00;44m\]\D{%M:%S}\[\033[00;33m\] \u@\h\[\033[00;37m\] \w\[\033[00;34m\]$(__git_ps1 " [%s]")\[\033[00;37m\]\n#\[\033[00m\] '
#export PS1='${debian_chroot:+($debian_chroot)}\u@\h\[\033[00;37m\] \w\[\033[00;34m\]$(__git_ps1 " [%s]")\[\033[00;37m\]\n#\[\033[00m\] '

export EDITOR='emacsclient -c'
export PATH=$PATH:~/bin:~/projs/gcc-arm/bin

export P4CONFIG=.p4config
export P4DIFF="/google/src/files/head/depot/google3/devtools/scripts/p4diff -w"
export P4MERGE=/home/build/public/eng/perforce/mergep4.tcl 
export P4EDITOR=$EDITOR

# turn off XON/XOFF control
stty -ixon
stty -ixoff

export GOOGLE3="/usr/local/google/home/varunmar/code/google3"
alias ds="cd $GOOGLE3/datawarehouse/datascape"
alias t="cd $GOOGLE3/datawarehouse/testing"

function client {
  CLIENT=$1;
  cd ~/clients/$CLIENT 2>/dev/null && cd google3/storage/f1 2>/dev/null
}
