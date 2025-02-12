# 🚀 Docker Cross Dev Env 🐳

Welcome to **Docker Cross Dev Env** – a fully equipped development container for cross-compiling software for **ARM64/ARMHF (Raspberry Pi)**! 🎉🐧

## !!! IN WORK !!!

## ✨ Features

- 🛠️ Pre-configured Debian container with C++ cross-building tools
- 🐳 Staring from using just the Debian:latest Docker Image 
- 🎯 Supports **ARM64** and **ARMHF** architectures
- 🏗️ Integrated `schroot` tool for QEMU-based execution of ARM binaries
- 🖥️ Easy VSCode integration with **Dev Containers**
- 🚀 Build everything on your host maschine  

---

## 🔧 VSCode Setup 🖥️

1️⃣ Open VSCode and press **F1** 📢

2️⃣ Search for **`Dev Containers: Reopen in Container`** 🔍

3️⃣ Wait while the container and environment are set up ⏳

This process includes:

✔️ Setting up a default **Debian-based** development container 🏗️

✔️ Installing cross-build tools for **ARM64/ARMHF** 🔧

✔️ Configuring `schroot` for QEMU emulation 🏎️

✔️ Installing necessary VSCode extensions (see [`.devcontainer/devcontainer.json`](./.devcontainer/devcontainer.json)) 📦

⚠️ **Note:** The setup will take some time to download Debian packages. Grab a ☕ and keep an eye on the progress! 🕵️‍♂️

---


## 🏗️ Advantages of `schroot` & Chroot Switching 🚀

`schroot` allows easy management of chroot environments, making it ideal for cross-development:

- 🔄 **Fast switching** between different chroot environments
- 🔧 **Fully isolated** environment for each target system
- 🛠️ **Exact replication** of Raspberry Pi environments, including toolchains and libraries
- 🏎️ **Efficient QEMU emulation**, enabling execution of ARM binaries on x86

### 🔹 Quick Guide to Using `schroot`

1️⃣ **List available chroot environments**
   ```sh
   schroot -l
   ```

2️⃣ **Enter a specific chroot**
   ```sh
   schroot -c <chroot_name>
   ```

2️⃣ **E.G. for Raspbee Zero - Enter a chroot**
   ```sh
   schroot -c raspi-armhf
   ```

3️⃣ **Run commands inside a chroot without entering it**
   ```sh
   schroot -c <chroot_name> -- <command>
   ```

4️⃣ **Create a new chroot environment** (Debian-based example)
   ```sh
   debootstrap --arch=arm64 bullseye /srv/chroot/raspi64 http://deb.debian.org/debian/
   ```

5️⃣ **Predefine chroot configuration in `/etc/schroot/schroot.conf`**

With `schroot`, you can create the **perfect development environment** for any Raspberry Pi model and seamlessly switch between them! 🎯🐧

---

## 👤 User & Permissions ⚠️

🔹 If running as **root**, be careful with file permissions! 🛑👀

🔹 Consider setting up a non-root user to avoid potential issues 🧑‍💻🚀

Enjoy coding for ARM with ease! 💻✨🐧