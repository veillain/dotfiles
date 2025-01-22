#!/bin/bash

#source
rn=$(pwd)
. $rn/install/pacman

#colors
NORMAL="\e[0m"
NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHTGRAY='\033[0;37m'
DARKGRAY='\033[1;30m'
LIGHTRED='\033[1;31m'
LIGHTGREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHTBLUE='\033[1;34m'
LIGHTPURPLE='\033[1;35m'
LIGHTCYAN='\033[1;36m'
WHITE='\033[1;37m'

function system-apply() {
  echo ''
  echo -n "Applying Display Manager.."
  used=$(grep 'ExecStart=' /etc/systemd/system/display-manager.service | awk -F= '{print $2}')
  if [ ! "$used" = greetd ]; then
    sudo systemctl disable $used
    sleep 0.5
    sudo systemctl enable greetd
    if [ $? -eq 0 ]; then
      echo -e "${GREEN}Success${NORMAL}"
    else
      echo -e "${RED}Failed${NORMAL}"
    fi
  else
    echo "Already greetd."
  fi
}

function apply() {
  echo ''
  echo -n "Applying the configuration.."
  #.config
  for file in $(ls -l .config | awk '{print $9}'); do 
    rm -rf $HOME/.config/$file
  done

  #.local
  for file in $(ls -l .local/share/fonts | awk '{print $9}'); do
    rm -rf $HOME/.local/share/fonts/$file
  done

  #themes
  for file in $(ls -l .themes | awk '{print $9}'); do
    rm -rf $HOME/.themes/$file
  done

  #icons
  for file in $(ls -l .icons | awk '{print $9}'); do
    rm -rf $HOME/.icons/$file
  done 

  stow . &>/dev/null
  if [ $? -eq 0 ]; then
    echo -e "${ORANGE}Success${NORMAL}"
  else
    echo -e "${RED}Failed${NORMAL}"
  fi
}

function aur-helper() {
  if sudo pacman -Q yay &>/dev/null; then
    echo ''
    echo -e "${ORANGE}AUR Helper already installed.${NORMAL}"
  else
    echo ''
    echo "Installing AUR Helper.."
    sudo pacman -S --noconfirm git &>/dev/null 
    git clone https://aur.archlinux.org/yay.git &>/dev/null
    cd yay
    makepkg -si
    if [ $? -eq 0 ]; then
      echo -e "${GREEN}Done${NORMAL}"
    else
      echo -e "${RED}Fail${NORMAL}"
    fi 
    cd ..
    rm -rf yay
  fi
}

function install-pkg() {
  echo ''
  echo "Installing all the depencencies.."
  for package in "${packages[@]}"; do 
    if sudo pacman -Q "$package" &>/dev/null; then
      echo -e "${ORANGE}$package is already installed.${NORMAL}"
    else
      echo -n "Stat $package.. "
      yay -S --noconfirm "$package" &>/dev/null
      if [ $? -eq 0 ]; then
        echo -e "\r${GREEN}Done${NORMAL}"
      else
        echo -e "\r${RED}Fail${NORMAL}"
      fi
    fi 
  done
}

function install() {
  aur-helper
  install-pkg
  apply
  system-apply
  exit
}

function double-check() {
  echo ''
  read -ep "Are you sure? All the data that same as in the dotfiles will be overwrited!!! (y/N) " answer2
  case $answer2 in 
    [yY]|[yY][eE][sS])
      install
      ;;
    [nN]|[nN][oO])
      exit 
      ;;
    *)
      exit
      ;;
  esac
}

while true; do 
  clear
  echo ''
  echo "################################################"
  echo "     Arch Bliss Configuations"
  echo "     veillainwertz@gmail.com"
  echo "     github.com/veillain/dotfiles"
  echo "################################################"
  echo ''
  echo "Bash: "$(echo $SHELL)""
  echo "Term: "$(echo $TERM)""
  echo "User: "$(whoami)""
  echo ''
  echo ''
  read -ep "Attention:
You will install Arch Bliss Configuration to your Desktop.
All the data that exist as in the dotfiles will be overwrited!!! (y/N) " answer
  case $answer in
    [yY]|[yY][eE][sS])
    double-check
      ;;
    [nN]|[nN][oO])
      break 
      ;;
    *)
      break
      ;;
  esac
done
