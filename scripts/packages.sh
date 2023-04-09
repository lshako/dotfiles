taps=(
  homebrew/cask
  homebrew/cask-fonts
  homebrew/core
  ox/ox
  vmware-tanzu/carvel
  wez/wezterm
)

packages=(
  bat                      #  https://github.com/sharkdp/bat
  bottom                   #  https://github.com/ClementTsang/bottom
  cmake
  ctags
  curl
  exa                      #  https://github.com/ogham/exa
  fzf                      #  https://github.com/junegunn/fzf
  fd                       #  https://github.com/sharkdp/fd
  gettext
  gpg
  go
  jq
  k9s                      #  https://github.com/derailed/k9s
  kubernetes-cli
  lazydocker               #  https://github.com/jesseduffield/lazydocker
  lazygit                  #  https://github.com/jesseduffield/lazygit
  libpq
  mas                      #  https://github.com/mas-cli/mas
  minikube
  neovim
  node
  nmap
  openjdk
  openssl
  postgresql
  procs                    #  https://github.com/dalance/procs/
  python3
  protobuf
  ripgrep                  #  https://github.com/BurntSushi/ripgrep
  rustup
  shellcheck
  stow
  telnet
  yarn
  wget
  zsh
  zsh-autosuggestions
  zsh-syntax-highlighting
  zoxide                   #  https://github.com/ajeetdsouza/zoxide
)

install_packages() {
  info "Configuring taps"
  apply_brew_taps "${taps[@]}"

  info "Installing packages..."
  install_brew_formulas "${packages[@]}"

  info "Cleaning up brew packages..."
  brew cleanup
}

post_install_packages() {
  info "Installing fzf bindings"
  # shellcheck disable=SC2046
  $(brew --prefix)/opt/fzf/install
}
