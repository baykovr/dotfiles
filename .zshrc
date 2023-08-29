export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="simple"

plugins=(git zsh-syntax-highlighting zsh-completions fzf-zsh-plugin)
source $ZSH/oh-my-zsh.sh

autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

PATH=/home/baykovr/bin:/usr/local/bin:/usr/local/go/bin:$PATH
PATH=$PATH:/home/baykovr/go/bin
PATH=/home/baykovr/.local/bin:$PATH

bindkey -v

#bindkey '^R' history-incremental-search-backward
bindkey "^R" fzf-history-widget
bindkey "^T" fzf-file-widget

source <(kubectl completion zsh)
alias k=kubectl

alias rs=redshift
alias gcl=gitlab-ci-local
alias l="exa -l"
alias lt="exa -l -T -L"
alias vim=nvim
alias bat="bat -p"

complete -o default -F __start_kubectl k

# source ${HOME}/bin/aws_zsh_complete.sh
eval "$(zoxide init zsh)"

# Use most(1) as the pager (e.g. man(1))
export PAGER=more
