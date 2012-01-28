autoload -U zmv
autoload colors; colors
HISTFILE=~/.histfile
HISTSIZE=SAVEHIST=9999
autoload -Uz compinit 
compinit
setopt correctall
autoload -U promptinit
setopt hist_ignore_all_dups
setopt hist_ignore_space

setopt incappendhistory
setopt sharehistory
setopt extendedhistory

#superglobs
setopt extendedglob
unsetopt caseglob
setopt interactivecomments # pound sign in interactive promt
REPORTTIME=10

#vi editing
bindkey -v

#autoload -Uz bashcompinit
#bashcompinit
#source /usr/local/share/compleat-1.0/compleat_setup

ZCACHEDIR=~/.zsh/cache
zstyle ':completion:*' cache-path $ZCACHEDIR 
zstyle ':completion:*' use-cache on
compinit -C -d $ZCACHEDIR/compdump
#color completions

zmodload -i zsh/complist
#zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
#zstyle ':completion:*' list-colors  'reply=( "=(#b)(*$PREFIX)(?)*=00=$color[green]=$color[bg-green]" )'
zstyle ':completion:*:*:kill:*' list-colors '=%*=01;31'
zstyle ':completion:*' format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'
# history
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes

# prevent svn files/dirs from being completd
zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)SVN'
zstyle ':completion:*:cd*' ignored-patterns '(*/)#SVN'
#fuzzy completions
zstyle ':completion:*' completor _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
# complete approx #'s increase w/ length
#zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'
#ignore completion for commands i don't have
zstyle ':completion:*:functions' ignored-patterns '_*'
xdvi() { command xdvi ${*:-*.dvi(om[1])} }
#menu selection for autocomplete
zstyle ':completion:*:*:xdvi:*' menu yes select
zstyle ':completion:*:*:xdvi:*' file-sort time
#pids menu selection
#zstyle 'completion:*:*:*:*:processes' menu yes select
#zstyle 'copmletion:*:*:*:*:processes' force-list always
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always
#If you end up using a directory as argument, this will 
#remove the trailing slash (usefull in ln)
zstyle ':completion:*' squeeze-slashes true
#cd never select the parent directory (e.g.: cd ../<TAB>):
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# I'm bonelazy ;) Complete the hosts and - last but not least - the remote
# directories. Try it:
#  $ scp file username@<TAB><TAB>:/<TAB>
zstyle ':completion:*:(ssh|scp|ftp|sftp):*' hosts $hosts
zstyle ':completion:*:(ssh|scp|ftp|sftp):*' users $users
#--------------

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="machinshin"

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"
OS=`uname`
if [[ "$OS" == "Linux" ]]; then
  # Comment this out to disable weekly auto-update checks
  DISABLE_AUTO_UPDATE="true"
fi

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(dirpersist extract history-substring-search vi-mode zsh-syntax-highlighting ssh git battery github svn)

source $ZSH/oh-my-zsh.sh
#export JETTY_VERSION=7.5.4.v20111024

# Customize to your needs...
#zsh specifc alias
alias mmv='noglob zmv -W'
alias ls='ls $LS_OPTIONS'
alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'

export PATH=$PATH:$HOME/scripts/
if [[ -f $HOME/scripts/corp.env.sh ]]; then 
  source $HOME/scripts/corp.env.sh
fi

if [[ -f $HOME/scripts/env.sh ]]; then 
  source $HOME/scripts/env.sh
fi
