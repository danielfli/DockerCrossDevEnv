#!/bin/bash

#! Choose your target architecture arm64 or armhf or both
arm64=false 
armhf=true

####################################################
#################### Setup Mirror ##################
####################################################

user="root"
mirrorDebianarm64="http://ftp.debian.org/debian"
mirrorDebianaarmhf="http://raspbian.raspberrypi.com/raspbian"
targetRelease="bookworm"
packageInchroot="cmake"

###################################################################################################################
########################################## Raspberry arm64 ########################################################

if [[ "${arm64}" == true ]]; then
    debootstrap --arch=arm64 --variant=buildd --components=main --include=$packageInchroot \
    $targetRelease /opt/raspberry/arm64 $mirrorDebianarm64 --verbose

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

###################################################################################################################
########################################### armhf##################################################################

if [[ "${armhf}" == true ]]; then
    debootstrap --arch=armhf --variant=buildd --components=main --no-check-gpg --include=$packageInchroot \
        $targetRelease /opt/raspberry/armhf $mirrorDebianaarmhf $targetRelease --verbose

#chroot config
cat <<EOF >>/etc/schroot/schroot.conf

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
