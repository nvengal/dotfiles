#!/usr/bin/env zsh

readonly STARSHIP_VERSION=1.4.1
echo "Installing starship ${STARSHIP_VERSION}"
asdf plugin add starship && \
  asdf install starship $STARSHIP_VERSION && \
  asdf global starship $STARSHIP_VERSION
