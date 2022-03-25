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

# for fun aliases
alias vim="nvim"
alias vimconfig="vim ~/.vimrc"
alias nvimconfig="nvim ~/.config/nvim/init.vim"
alias zconfig="vim ~/.zshrc && source ~/.zshrc"
alias i3config="vim ~/.i3/config"
alias rg="rg -S --type=py --type=ts"

# binding for fzf
source /usr/share/fzf/key-bindings.zsh

alias pushpersonal="rclone sync /home/dweisdorf/Documents/weisdorf-data encrypted-data:weisdorf-data"

alias cat="bat"
alias am="cd ~/repos/ArcMachine"
alias amb="cd ~/repos/TrajektWeb/python_server/model_building"
alias arc="am && source arc/bin/activate"

export PYTHONPATH="${PYTHONPATH}:/home/dweisdorf/repos/ArcMachine"
alias sshtrajekt="ssh -i ~/Downloads/TrajektSports-Key3.pem ubuntu@trajektsports.app"

export BROWSER=/usr/bin/chrome

# IMPORT TRAJEKT ENV VARIABLES
if [[ -e /home/dweisdorf/.trajektenv ]]; then
  source /home/dweisdorf/.trajektenv
fi
