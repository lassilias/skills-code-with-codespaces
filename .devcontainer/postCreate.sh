#!/bin/bash

set -e

# basic packages and build deps for compiling Python
sudo apt-get update
sudo apt-get install -y build-essential curl git libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev libffi-dev liblzma-dev

# optional fun tool
sudo apt-get install -y sl || true

# install pyenv if missing
if [ ! -d "$HOME/.pyenv" ]; then
  curl https://pyenv.run | bash
fi

# add pyenv init to shell rc if not already present
if ! grep -q 'pyenv init' ~/.bashrc 2>/dev/null; then
  cat >> ~/.bashrc <<'BASHRC'
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
BASHRC
fi

# load pyenv for the current script
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# install Python 3.10 (no-op if already installed)
PYVER="3.10.8"
pyenv install -s "$PYVER"
pyenv global "$PYVER"

# ensure pip and debugpy present
pip install --upgrade pip
pip install --upgrade debugpy

# ...existing code...
echo "export PATH=\$PATH:/usr/games" >> ~/.bashrc
echo "export PATH=\$PATH:/usr/games" >> ~/.zshrc