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

alias l="exa -l"
alias lt="exa -l -T -L"

alias nix-eval="nix-instantiate --eval --strict"

alias vim=nvim
alias tf="terraform"
alias tfa="terraform apply -auto-approve"

alias ec2-ls="aws ec2 describe-instances --query 'Reservations[*].Instances[*].InstanceId' --output text |cat"
alias ec2-ssm="aws ssm start-session --target"
alias ecr-ls="aws ecr describe-repositories | jq -r '.repositories.[].repositoryName'"

complete -o default -F __start_kubectl k

source ${HOME}/bin/aws_zsh_completer.sh
eval "$(zoxide init zsh)"

export PAGER=less
