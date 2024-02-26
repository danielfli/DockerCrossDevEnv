#!/bin/bash

#This Skript ist for setting up, the arm64 crossbuild env 

arm64=true 

####################################################
#################### Setup Mirror ##################
####################################################

user="root"
mirrorDebian="http://ftp.debian.org/debian"
targetRelease="bookworm"
packageInchroot="cmake,sudo"

####################################################
#################### doing ... #####################
####################################################

if [[ "${arm64}" == true ]]; then
    debootstrap --arch=arm64 --variant=buildd --components=main --include=$packageInchroot \
    $targetRelease /opt/raspberry/arm64 $mirrorDebian $targetRelease --verbose

#chroot config
cat <<EOF >>/etc/schroot/schroot.conf

[raspi-arm64]
description=chroot raspberry pi
type=directory
directory=/opt/raspberry/arm64
users=root

EOF

  if [[ "${user}" == "root" ]]; then
    echo "/$user/workspace /$user/workspace none rw,bind 0 0" | sudo tee -a /etc/schroot/default/fstab
  else
    echo "/home/$user/workspace /home/$user/workspace none rw,bind 0 0" | sudo tee -a /etc/schroot/default/fstab 
  fi

  echo "/opt/raspberry/arm64 /opt/raspberry/arm64 none rw,bind 0 0" | sudo tee -a /etc/schroot/default/fstab 
fi

