#! /bin/bash

function install_neovim () {
  echo "installing neovim"

  url="https://raw.githubusercontent.com/LeonardsonCC/ansible-playbooks/main/Neovim.yml"
  dest="/tmp/ansible-installations/Neovim.yml"

  wget "${url}" -O "${dest}"
  ansible-playbook "${dest}"
}

if [ ! -f "/bin/ansible" ]; then
  echo "Sorry! You need ansible to run this script..."
  exit 1
fi

echo "Starting installations"

# Check what install
for script in "$@"
do
  case "${script}" in
    -n) INSTALL_NEOVIM=1;;
    --neovim) INSTALL_NEOVIM=1;;

    -a) INSTALL_ALL=1;;
    --all) INSTALL_ALL=1;;
  esac
done

mkdir /tmp/ansible-installations

if [ "$INSTALL_ALL" == 1 ]; then
  INSTALL_NEOVIM=1
fi

if [ "$INSTALL_NEOVIM" == 1 ]; then
  install_neovim
fi

rm -rf /tmp/ansible-installations

echo "Finished"
