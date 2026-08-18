FROM debian:12-slim

# Install required software
RUN apt-get update \
    && apt-get install --quiet --assume-yes \
    clang-15 clangd-15 \
    libstdc++-12-dev libomp-15-dev \
    gdb \
    ninja-build \
    cmake \
    libtbb-dev \
    zip

# Install VSCode (adapted from https://computingforgeeks.com/how-to-install-visual-studio-code-on-ubuntu/)
RUN apt update
RUN apt install -qy wget gpg apt-transport-https
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /usr/share/keyrings/packages.microsoft.gpg > /dev/null
RUN echo "deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list
RUN echo "deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list
RUN apt update
RUN apt install -qy code

# Clean apt to save storage space
RUN rm -rf /var/lib/apt/lists/*

# Create and switch to user 'cppcourse'
RUN useradd -m -s /bin/bash cppcourse
RUN mkdir -p /home/cppcourse/.config/Code /tmp/runtime
RUN chown -R cppcourse:cppcourse /home/cppcourse
RUN chmod -R 777 /tmp/runtime
USER cppcourse

# Install required extensions
RUN code --no-sandbox --install-extension ms-vscode.cpptools
RUN code --no-sandbox --install-extension llvm-vs-code-extensions.vscode-clangd 
RUN code --no-sandbox --install-extension twxs.cmake 
RUN code --no-sandbox --install-extension ms-vscode.cmake-tools 
RUN code --no-sandbox --install-extension usernamehw.errorlens

# Vim mode (disable if not desired)
RUN code --no-sandbox --install-extension vscodevim.vim

WORKDIR /home/cppcourse
ENTRYPOINT ["code", "--no-sandbox", "--wait"]
