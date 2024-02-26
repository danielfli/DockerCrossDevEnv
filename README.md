# Docker Cross Dev Env 

Devcontainer environment for developing software for arm64 arch (Raspi).  


## VSCode Setup 

Press F1 and search for `Dev Containers: Reopen in Container` and wait for setting up the container and the env. 

1. Setup a defualt Debian Container with some C++ Tools 

2. Setup the CrossBuild environment for arm64 

3. Setup Chroot Tool `schroot` for qemu emulation running bin for arm64 arch 

4. Install VSCode Extension from the [.devcontainer/devcontainer.json](./.devcontainer/devcontainer.json)


It will need a while for downloading some debian packages. See the processing status. 


## User 

If running as root, be carefull with the permission on the files. 