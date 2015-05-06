# dotfiles

## Dependencies

First, you will need to install Homebrew:

    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

These dotfiles use [rcm](https://github.com/thoughtbot/rcm). To install:

    brew tap thoughtbot/formulae
    brew install rcm

## Installation

    git clone https://github.com/damselem/dotfiles.git ~/.dotfiles
    env RCRC=$HOME/.dotfiles/rcrc rcup -k
