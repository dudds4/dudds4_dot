# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
bindkey -s '^t' "tm-sess\n"

docker-bash() {
    local -a dservices
    dservices=("${(@f)$(docker-compose ps --services)}")

    local -a docker_options
    docker_options=(
        "docker-compose exec backend python3 manage.py migrate"
        "\ndocker-compose exec backend python3 manage.py shell"
        "\ndocker-compose exec frontend npm install"
        "\ndocker-compose logs"
        "\ndocker-compose logs --follow"
        "\ndocker-compose exec frontend npx tailwind -i src/tailwind_src/ExportPage.css -o src/tailwind_dst/ExportPage.css --watch"
    )

    for serv in $dservices; do
        docker_options+="\ndocker-compose exec $serv bash"
    done

    if [ $# -gt 0 ]; then
        filtered_options=$(echo $docker_options | grep $1)

        # if there's only one option, just run it.
        if [[ $(echo $filtered_options | grep "^docker-compose" | wc -l) = 1 ]]; then
            eval "$filtered_options"
            return
        fi
        selected_option=$(echo $filtered_options | fzf)
    else
        selected_option=$(echo $docker_options | fzf)
    fi

    eval "$selected_option"
}
alias db=docker-bash

export GOOGLE_APPLICATION_CREDENTIALS=$HOME/repos/companion_keys/companion-project-354714-8e95cff3de8d.json

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
