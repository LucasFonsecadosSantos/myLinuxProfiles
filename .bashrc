#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '
PS1="\[\e[01;37m\][\[\e[0m\]\[\e[01;32m\]\u\[\e[0m\]\[\e[00;37m\]@\[\e[0m\]\[\e[01;34m\]\h\[\e[0m\]\[\e[00;37m\] \[\e[0m\]\[\e[00;37m\]\t\[\e[0m\]\[\e[01;37m\] \W]\\$ \[\e[0m\]"
#PS1="\n\[\e[01;33m\]\u\[\e[0m\]\[\e[00;37m\]@\[\e[0m\]\[\e[01;36m\]\h\[\e[0m\]\[\e[00;37m\] \t \[\e[0m\]\[\e[01;35m\]\w\[\e[0m\]\[\e[01;37m\] \[\e[0m\]\n$ "
#PS1="\[\e[01;33m\]\u\[\e[0m\]\[\e[00;37m\]@\[\e[0m\]\[\e[01;36m\]\h\[\e[0m\]\[\e[00;37m\] \t \[\e[0m\]\[\e[01;35m\]\w\[\e[0m\]\[\e[01;37m\] > \[\e[0m\]"
#PS1="\[\e[01;37m\][\[\e[0m\]\[\e[01;31m\]\u\[\e[0m\]\[\e[00;37m\]@\[\e[0m\]\[\e[01;34m\]\h\[\e[0m\]\[\e[00;37m\] \[\e[0m\]\[\e[00;37m\]\t\[\e[0m\]\[\e[01;37m\] \W]\\$ \[\e[0m\]"

#!/bin/sh

to_nvidia_conf() {
  echo "blacklist nouveau" | sudo tee /etc/modprobe.d/modprobe.conf
  sudo sed  -i 's/MODULES="nouveau"/#MODULES=""/' /etc/mkinitcpio.conf
  sudo mkinitcpio -p linux
}

to_nouveau_conf() {
  echo "" | sudo tee /etc/modprobe.d/modprobe.conf
  sudo sed -i 's/#MODULES=""/MODULES="nouveau"/' /etc/mkinitcpio.conf
  sudo mkinitcpio -p linux
}

to-nvidia() {
	#remove nouveau stuff
	sudo pacman -R lib32-nouveau-dri xf86-video-nouveau nouveau-dri
	
	#install nvidia stuff
  sudo pacman -S --needed nvidia nvidia-libgl lib32-nvidia-libgl 
  sudo pacman -S --needed nvidia-utils lib32-nvidia-utils
  to_nvidia_conf
}

to-nouveau() { 
  sudo pacman -R nvidia
  sudo pacman -S --needed mesa mesa-libgl lib32-mesa lib32-mesa-libgl 
nouveau-dri lib32-nouveau-dri
  sudo pacman -R nvidia-libgl lib32-nvidia-libgl nvidia-utils 
lib32-nvidia-utils
  
  
  #install nouveau stuff
  sudo pacman -S --needed cairo khrplatform-devel libdrm 
xf86-video-nouveau
  
  to_nouveau_conf
}
