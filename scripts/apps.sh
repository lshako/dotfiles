apps=(
  docker
  firefox
  google-chrome
  alacritty
  slack
  visual-studio-code
  obsidian
)

install_macos_apps() {
  info "Installing macOS apps..."
  install_brew_casks "${apps[@]}"
}
