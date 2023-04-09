#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

. scripts/utils.sh
. scripts/brew.sh
. scripts/apps.sh
. scripts/cli.sh
. scripts/config.sh
. scripts/osx.sh
. scripts/fonts.sh
. scripts/packages.sh
. scripts/oh-my-zsh.sh

cleanup() {
  err "Last command failed"
  info "Finishing..."
}

wait_input() {
  read -p -r "Press enter to continue: "
}

main() {
  info "Installing ..."

  info "################################################################################"
  info "Homebrew Packages"
  info "################################################################################"
  wait_input
  install_packages

  post_install_packages
  success "Finished installing Homebrew packages"

  info "################################################################################"
  info "Homebrew Fonts"
  info "################################################################################"
  wait_input
  install_fonts
  success "Finished installing fonts"

  info "################################################################################"
  info "Oh-my-zsh"
  info "################################################################################"
  wait_input
  install_oh_my_zsh
  success "Finished installing Oh-my-zsh"

  info "################################################################################"
  info "MacOS Apps"
  info "################################################################################"
  wait_input
  install_macos_apps


  info "################################################################################"
  info "Configuration"
  info "################################################################################"
  wait_input

  setup_osx
  success "Finished configuring MacOS defaults. NOTE: A restart is needed"

  code_as_default_text_editor
  success "Finished setting up VSCode as default text editor"

  stow_dotfiles
  success "Finished stowing dotfiles"

  info "################################################################################"
  info "Crating git folders"
  info "################################################################################"
  mkdir -p ~/git/work
  mkdir -p ~/git/private

  info "################################################################################"
  info "SSH Key"
  info "################################################################################"
  setup_github_ssh
  success "Finished setting up SSH Key"

  if ! hash rustc &>/dev/null; then
    info "################################################################################"
    info "Rust Setup"
    info "################################################################################"
    wait_input
    rustup-init
  fi

  success "Done"

  info "System needs to restart. Restart?"

  select yn in "y" "n"; do
    case $yn in
        y ) sudo shutdown -r now; break;;
        n ) exit;;
    esac
  done
}

trap cleanup SIGINT SIGTERM ERR EXIT

main
