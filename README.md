# dotfiles

Config files managed using [stow](https://www.gnu.org/software/stow/manual/stow.html)

## Install

- sudo apt install zsh
- sudo apt install vim
- Install docker + docker-compose
  - https://docs.docker.com/engine/install/ubuntu/
  - sudo apt install docker-compose
- zsh ./install.sh
- zsh ./setup-debian.sh
- vim +PlugInstall
- chsh -s /bin/zsh

## Colorschemes

Uses https://github.com/Mayccoll/Gogh

```bash
# Mac (requires iterm)
bash -c "$(curl -sLo- https://git.io/vQgMr)"
```
```bash
# Linux
sudo apt-get install dconf-cli uuid-runtime
bash -c "$(wget -qO- https://git.io/vQgMr)"
```
