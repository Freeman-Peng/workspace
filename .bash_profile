#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
#alias
alias ls='ls --color=always'
alias grep='grep --color=always'


#git profile
_gitbranch() {
local _branchname=`git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3`
[[ ! -z "$_branchname" ]] && echo "($_branchname)"
}
PS1="[\u@\h \W]\[\e[1;33m\]\$(_gitbranch)\[\e[0m\]\$"

#ssh-agent
eval `ssh-agent` >/dev/null 2>&1
ssh-add ~/.ssh/id_rsa_github >/dev/null 2>&1

#go profile
export GOPATH=~/go
export GOBIN=~/go/bin
export PATH=$PATH:$GOBIN

#less profile
export LESSCHARSET=UTF-8



#export JAVA_HOME=/usr/lib/jvm/default
#export JRE_HOME=$JAVA_HOME/jre
#export CLASSPATH=.:$JAVA_HOME/lib:$JRE_HOME/lib:
#export PATH=$JAVA_HOME/bin:$PATH
