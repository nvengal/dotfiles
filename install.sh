#!/usr/bin/env bash

set -e

install_fonts() {
  # Nerd Fonts
  # https://github.com/ryanoasis/nerd-fonts
  if ! (fc-list | grep -q FiraCode)
  then
    artifact="FiraCode.zip"
    version="v2.3.3"
    curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/$version/$artifact
    unzip -o $artifact -d $HOME/.fonts
    rm $artifact
    fc-cache -fv
  fi
}

install_vim_plug() {
  # https://github.com/junegunn/vim-plug
  if [ ! -f "${HOME}/.vim/autoload/plug.vim" ]
  then
    curl -fLo ${HOME}/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim +PlugInstall +qall
  fi
}

install_vim() {
  install_vim_plug

  if [ ! -x "$(command -v nvim)" ]
  then
    wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.appimage
    sudo chmod u+x nvim-linux-x86_64.appimage
    sudo mv nvim-linux-x86_64.appimage /usr/bin/nvim
  fi
}

# https://www.rust-lang.org/tools/install
install_rust() {
  if [ ! -x "$(command -v rustup)" ]
  then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
  fi
}

# https://github.com/BurntSushi/ripgrep grep so fast
# https://github.com/jdxcode/mise asdf in rust
# https://starship.rs fancy prompt
# https://github.com/dbrgn/tealdeer fast tldr
# https://github.com/zellij-org/zellij terminal multiplexer
install_cargo_packages() {
  packages="mise ripgrep starship tealdeer zellij"
  cargo install --locked $packages
  tldr --update
}

install_alacritty_terminfo() {
  if ! infocmp alacritty > /dev/null; then
    curl \
      --fail \
      --location \
      --output /tmp/alacritty.info \
      https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info

    sudo tic -xe alacritty,alacritty-direct /tmp/alacritty.info
  fi
}

# command-line fuzzy finder https://github.com/junegunn/fzf
install_fzf() {
  if [ ! -d "${HOME}/.fzf" ]
  then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    $HOME/.fzf/install
  fi
}

install_fzf_brew() {
  $(brew --prefix)/opt/fzf/install \
    --xdg \
    --no-update-rc \
    --key-bindings \
    --completion
}

# https://docs.docker.com/engine/install/debian/
install_docker() {
  if [ ! -x "$(command -v docker)" ]
  then
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh ./get-docker.sh
    dockerd-rootless-setuptool.sh install
    sudo apt install --assume-yes docker-compose
    rm get-docker.sh
  fi
}

install_homebrew() {
  if [ ! -x "$(command -v brew)" ]
  then
    NONINTERACTIVE=1 /bin/bash -c "$(
      curl  --fail --location --show-error --silent \
        https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
    )"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
}

install_linux() {
  packages="alacritty build-essential cmake curl fd-find file git jq libssl-dev pkg-config stow tig tree uidmap unzip vim xclip"
  sudo apt update && sudo apt install --assume-yes $packages
  stow alacritty bash git nvim vim
  install_fonts
  install_vim
  install_rust
  install_cargo_packages
  install_alacritty_terminfo
  install_fzf
  install_docker
}

install_darwin() {
  install_homebrew
  packages="fd fzf git stow vim nvim jq tig tree awscli openssl@1.1 openssl@3 llvm cmake"
  brew install $packages

  source ./zsh/.zprofile
  stow alacritty-mac git nvim vim zsh

  brew tap common-fate/granted
  brew install granted

  install_vim_plug
  install_fzf_brew
  install_rust
  install_cargo_packages
}

main() {
  os=$(uname | tr '[:upper:]' '[:lower:]')
  case $os in
    linux | darwin)
      install_$os
      ;;
    *)
      echo $os not supported
      exit 1
      ;;
  esac
}

main
