#! /bin/bash

function ask_for_sudo () {
  sudo "$0" "$@"
}

function install_neovim () {
  echo "installing neovim"

  url="https://raw.githubusercontent.com/LeonardsonCC/ansible-playbooks/main/Neovim.yml"
  dest="/tmp/ansible-installations/Neovim.yml"

  wget "${url}" -O "${dest}"
  ansible-playbook "${dest}"
}

function install_dotfiles () {
  echo "installing dotfiles"

  url="https://raw.githubusercontent.com/LeonardsonCC/ansible-playbooks/main/Dotfiles.yml"
  dest="/tmp/ansible-installations/Dotfiles.yml"

  wget "${url}" -O "${dest}"
  ansible-playbook "${dest}"
}

function install_packages () {
  echo "installing packages"

  url="https://raw.githubusercontent.com/LeonardsonCC/ansible-playbooks/main/Packages.yml"
  dest="/tmp/ansible-installations/Packages.yml"

  wget "${url}" -O "${dest}"
  ansible-playbook "${dest}"
}

function install_ui () {
  echo "installing ui"

  url="https://raw.githubusercontent.com/LeonardsonCC/ansible-playbooks/main/Ui.yml"
  dest="/tmp/ansible-installations/Ui.yml"

  wget "${url}" -O "${dest}"
  ansible-playbook "${dest}"
}

if [ ! -f "/bin/ansible" ]; then
  echo "Sorry! You need ansible to run this script..."
  exit 1
fi

# Check what install
for script in "$@"
do
  case "${script}" in
    -n) INSTALL_NEOVIM=1;;
    --neovim) INSTALL_NEOVIM=1;;

    -d) INSTALL_DOTFILES=1;;
    --dotfiles) INSTALL_DOTFILES=1;;

    -p) INSTALL_PACKAGES=1;;
    --packages) INSTALL_PACKAGES=1;;

    -u) INSTALL_UI=1;;
    --ui) INSTALL_UI=1;;

    -a) INSTALL_ALL=1;;
    --all) INSTALL_ALL=1;;
  esac
done

TMP_FOLDER=/tmp/ansible-installations

if [ "$INSTALL_ALL" == 1 ]; then
  INSTALL_NEOVIM=1
  INSTALL_PACKAGES=1
  INSTALL_UI=1
fi

if [ "$INSTALL_PACKAGES" == 1 ]; then
  ask_for_sudo
fi

echo "Installing..."

# create tmp folder
if [ ! -d $TMP_FOLDER ]; then
  mkdir "$TMP_FOLDER"
fi

if [ "$INSTALL_PACKAGES" == 1 ]; then
  install_packages
fi

if [ "$INSTALL_NEOVIM" == 1 ]; then
  install_neovim
fi

if [ "$INSTALL_DOTFILES" == 1 ]; then
  install_dotfiles
fi

if [ "$INSTALL_UI" == 1 ]; then
  install_ui
fi

if [ -d $TMP_FOLDER ]; then
  rm -rf "$TMP_FOLDER"
fi

echo "Finished"
