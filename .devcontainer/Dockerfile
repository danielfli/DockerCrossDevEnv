FROM debian:latest

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

RUN dpkg --add-architecture arm64

RUN apt-get update && apt-get -y --no-install-recommends install \
    bash bash-completion \
    build-essential \
    git \
    schroot debootstrap ubuntu-dev-tools \
    cmake \
    gdb \
    wget \
    clangd \
    clang-format \
    ninja-build \
    ccache \
    ssh \
    #! armhf e.g. Rasp 1/Zero 
        #gcc-arm-linux-gnueabihf \
        #g++-arm-linux-gnueabihf \
        #crossbuild-essential-armhf \
    #! arm64 e.g. Rasp3/Rasp4
    gcc-aarch64-linux-gnu \
    g++-aarch64-linux-gnu \
    crossbuild-essential-arm64 \
    rsync 

RUN apt-get clean autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

COPY ./install.sh /tmp/
RUN chmod +x /tmp/install.sh && /tmp/install.sh \
    && rm -f /tmp/install.sh


