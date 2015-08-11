# vim:syntax=sh

ZSH_DIR=$HOME/.dotfiles/zsh

source $ZSH_DIR/prompt
source $ZSH_DIR/path

# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc
export CLICOLOR=1
