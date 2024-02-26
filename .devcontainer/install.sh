#!/bin/bash

####################################################
###### Toolchain - YOUR Target (multi ok) ##########
####################################################

arm64=true 
raspizero=false 
raspipico=false 

####################################################
#################### Setup Mirror ##################
####################################################

user="dan"
targetMirrorarmhf="http://raspbian.raspberrypi.org/raspbian"
mirrorDebian="http://ftp.debian.org/debian/"
targetRelease="bookworm"
packageInchroot="cmake,sudo"


####################################################
#################### doing ... #####################
####################################################


# if [ "$raspi4" = true ] ; then
#     wget -O- https://github.com/tttapa/docker-arm-cross-toolchain/releases/latest/download/x-tools-aarch64-rpi3-linux-gnu.tar.xz | tar xJ -C ~/opt
    
#     # add compilier to path 
#     echo 'export PATH="$HOME/opt/x-tools/aarch64-rpi3-linux-gnu/bin:$PATH"' >> ~/.profile
# fi


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



if [[ ($raspizero == "true" || $raspipico == "true") ]]; then
    debootstrap --arch=armhf --variant=buildd --include=$packageInchroot \
    $targetRelease /opt/raspberry/armhf $mirrorDebian $targetRelease --verbose

    wget -O-  https://archive.raspbian.org/raspbian.public.key | gpg --dearmor | sudo tee /usr/share/keyrings/elberepoamd64.gpg >/dev/null


cat <<EOF >/etc/schroot/schroot.conf

[raspi-armhf]
description=chroot raspberry pi
type=directory
directory=/opt/raspberry/armhf
users=root

EOF

  if [[ "${user}" == "root" ]]; then
    echo "/$user/workspace /$user/workspace none rw,bind 0 0" | sudo tee -a /etc/schroot/default/fstab
  else
    echo "/home/$user/workspace /home/$user/workspace none rw,bind 0 0" | sudo tee -a /etc/schroot/default/fstab 
  fi

  echo "/opt/raspberry/armhf /opt/raspberry/armhf none rw,bind 0 0" | sudo tee -a /etc/schroot/default/fstab 
fi

