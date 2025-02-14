FROM debian:latest

#! ToDo Setup for user creation
# ARG USERNAME=dan
# ARG USER_UID=1000
# ARG USER_GID=$USER_UID
# # Create the user
# RUN groupadd --gid $USER_GID $USERNAME \
#     && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
#     && apt-get update \
#     && apt-get install -y sudo \
#     && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
#     && chmod 0440 /etc/sudoers.d/$USERNAME

#! Install the basic development tools
RUN apt-get update && apt-get -y --no-install-recommends install \
    bash bash-completion \
    build-essential \
    git \
    schroot debootstrap ubuntu-dev-tools \  
    wget rsync ssh \
    cmake ccache clangd clang-format ninja-build gdb

#! Activate for amd64 crossbuild
# RUN dpkg --add-architecture arm64
# RUN apt-get -y --no-install-recommends install \
#     crossbuild-essential-arm64 

#! Activate for armhf crossbuild
RUN dpkg --add-architecture armhf
RUN apt-get -y --no-install-recommends install \
    crossbuild-essential-armhf

#! Clean up apt cache
RUN apt-get clean autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

#! Install the crossbuild environment 
COPY ./install.sh /tmp/
RUN chmod +x /tmp/install.sh && /tmp/install.sh \
    && rm -f /tmp/install.sh

#! Copy the bashrc configuration
COPY ./conf/.bashrc /root/.bashrc

