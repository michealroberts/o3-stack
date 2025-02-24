# //////////////////////////////////////////////////////////////////////////////////////////////////////////////////// #

FROM debian:bookworm AS development

# //////////////////////////////////////////////////////////////////////////////////////////////////////////////////// #

# Create and use /app as the working directory
WORKDIR /usr/src/app

# //////////////////////////////////////////////////////////////////////////////////////////////////////////////////// #

# Install necessary packages: gcc, make, libc-dev, bash, curl, and openssh-client
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    ca-certificates \
    curl \
    gcc \
    git \
    libc-dev \
    make \
    openssh-client \
    unzip \
    wget \
    zsh \
    && rm -rf /var/lib/apt/lists/*

# Install Bun
RUN curl -fsSL https://bun.sh/install | bash

# Set the BUN_INSTALL environment variable
ENV BUN_INSTALL="/root/.bun"

# Set the PATH to include Bun
ENV PATH="$BUN_INSTALL/bin:$PATH"

# Configure Zsh with Bun
RUN echo 'export BUN_INSTALL="/root/.bun"' >> ~/.zshrc 
RUN echo 'export PATH="$BUN_INSTALL/bin:$PATH"' >> ~/.zshrc

# Install Oh My Zsh non-interactively
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install zsh-in-docker non-interactively
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.5/zsh-in-docker.sh)" -- \
    -t https://github.com/denysdovhan/spaceship-prompt \
    -a 'SPACESHIP_PROMPT_ADD_NEWLINE="false"' \
    -a 'SPACESHIP_PROMPT_SEPARATE_LINE="false"' \
    -p git \
    -p ssh-agent \
    -p https://github.com/zsh-users/zsh-autosuggestions \
    -p https://github.com/zsh-users/zsh-completions

# Copy your project files into the container
COPY . /usr/src/app/

# //////////////////////////////////////////////////////////////////////////////////////////////////////////////////// #

# Set the default shell to zsh
SHELL ["/bin/zsh", "-c"]

# //////////////////////////////////////////////////////////////////////////////////////////////////////////////////// #