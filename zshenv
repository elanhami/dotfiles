ZSH_DIR=$HOME/.zsh

# If we are running in login mode, let .zprofile set the PATH. Otherwise it would be duplicated.
if [[ ! (-o login) ]]; then
  source $ZSH_DIR/path
fi
