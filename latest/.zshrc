# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi

# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

# turns on keychain for ssh key management
eval $(keychain --eval --quiet id_rsa)

# make fzf use rg over find
if type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND="rg --files"
    export FZF_CTRL_T_COMMAND="rg --files"
fi

# for fun aliases
alias vim="nvim"
alias vimconfig="vim ~/.vimrc"
alias nvimconfig="nvim ~/.config/nvim/init.vim"
alias zconfig="vim ~/.zshrc && source ~/.zshrc"
alias i3config="vim ~/.i3/config"
alias rg="rg -S -g '!**/snap*.py'"

# warn if there are any keybindings that will get overwritten
# by fzf

# binding for fzf
source /usr/share/fzf/key-bindings.zsh

# update certain default bindings
# -- in particular, unmap from ^T and map ^P
bindkey -r '^T'
bindkey -M emacs '^K' fzf-file-widget
bindkey -M vicmd '^K' fzf-file-widget
bindkey -M viins '^K' fzf-file-widget

# alias pushpersonal="rclone sync /home/dweisdorf/Documents/weisdorf-data encrypted-data:weisdorf-data"

alias cat="bat"
# alias am="cd ~/repos/ArcMachine"
# alias amb="cd ~/repos/TrajektWeb/python_server/model_building"
# alias arc="am && source arc/bin/activate"
# alias stu="cd ~/repos/SettleUp/"

export PATH="${HOME}/repos/dudds4_dot/bin/:$PATH"
export PYTHONPATH="${PYTHONPATH}:/home/dweisdorf/repos/ArcMachine"

export SPARK_HOME="$HOME/repos/spark-3.3.0-bin-hadoop3"
export PATH="$SPARK_HOME/bin:$PATH"

alias sshtrajekt="ssh -i ~/Downloads/TrajektSports-Key3.pem ubuntu@trajektsports.app"

# aliases for sourcedfact
# alias eslint="eslint_d"
alias flake8="python3 -m flake8"
# alias run_sourcedfact="docker-compose -f docker-compose.yml -p sourcedfact up -d"

export BROWSER=/usr/bin/chrome
export COMPANIONHOME=/home/dweisdorf/repos/

# # IMPORT TRAJEKT ENV VARIABLES
# if [[ -e /home/dweisdorf/.trajektenv ]]; then
#   source /home/dweisdorf/.trajektenv
# fi

# source /usr/share/nvm/init-nvm.sh

lazy_load_nvm() {
  unset -f node nvm npm npx
  export NVM_DIR=~/.nvm
  [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
}

node() {
  lazy_load_nvm
  node $@
}

nvm() {
  lazy_load_nvm
  nvm $@
}

npm() {
  lazy_load_nvm
  npm $@
}

npx() {
  lazy_load_nvm
  npx $@
}


source /home/dweisdorf/repos/companion/.zsh_config
alias prettier="npx prettier --write --tab-width 4"
alias ls="ls -l --color=auto"
bindkey -s '^t' "tmux-sessionizer\n"

docker-bash() {
    service=$(docker-compose ps --services | fzf)
    docker-compose exec $service bash
}
alias db=docker-bash

export GOOGLE_APPLICATION_CREDENTIALS=$HOME/repos/companion_keys/companion-project-354714-8e95cff3de8d.json
