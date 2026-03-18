#! /bin/env zsh



# requirement

requirements=( 
  git 
  sh 
  zsh 
  fzf
)
zsh_plugins=(
  Aloxaf/fzf-tab
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-autosuggestions
)



check_requirement() {
  if ! command -v $1 > /dev/null 2>&1; then
    print -P "%F{red}ERROR:%f can't find command %F{cyan}\`$1\`%f"
    exit 1
  fi
}



# install oh_my_zsh plugins (not built-in).
clone_plugins() {
  for plugin in "${zsh_plugins[@]}"; do
    git clone "https://github.com/$plugin" $HOME/.oh-my-zsh/plugins/$(basename $plugin) --depth 1``
  done
}



install_ohmyzsh() {
  if command -v curl > /dev/null 2>&1; then
    curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh| sh
  elif command -v wget > /dev/null 2>&1; then
    wget -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh| sh
  else
    print -P "%F{red}ERROR:%f can't find eater of this commands [%F{cyan}\`curl\`, \`wget\`%f]"
  fi

}



for cmd in "${requirements[@]}"; do
  check_requirement $cmd
done




install_ohmyzsh
clone_plugins
curl -fsSL "https://raw.githubusercontent.com/smahraz/.config/master/zsh/.zshrc" > $HOME/.zshrc 

zsh
