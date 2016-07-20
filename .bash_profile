#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
#alias
alias ls='ls --color=always'
alias grep='grep --color=always'
alias ll='ls --color=alway -al'
export LC_CTYPE=zh_CN.UTF-8
export LANG=en_US.UTF-8


#git profile
_gitbranch() {
local _branchname=`git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3`
[[ ! -z "$_branchname" ]] && echo "($_branchname)"
}
PS1="[\u@\h \W]\[\e[1;33m\]\[\$(_gitbranch)\]\[\e[00m\]\$"

#ssh-agent
_cleanssh() {
	kill $SSH_AGENT_PID
}
trap _cleanssh EXIT
eval `ssh-agent` >/dev/null 2>&1
ssh-add ~/.ssh/id_rsa_github >/dev/null 2>&1

#go profile
export GOPATH=~/go
export PATH=$PATH:~/go/bin

#less profile
export LESSCHARSET=UTF-8
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
export GTK_IM_MODULE=ibus
