# //////////////////////////////////////////////////////////////////////////////////////////////////////////////////// #

FROM debian:bookworm AS development

# //////////////////////////////////////////////////////////////////////////////////////////////////////////////////// #

# Create and use /app as the working directory
WORKDIR /usr/src/app

# //////////////////////////////////////////////////////////////////////////////////////////////////////////////////// #

# Copy the root package manifest early so the Bun version can stay aligned with package.json
COPY package.json /usr/src/app/package.json

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
    && rm -rf /var/lib/apt/lists/*

# Install Bun
RUN bash -lc 'BUN_VERSION="$(grep -oE "\"packageManager\": \"bun@[^\"]+\"" package.json | cut -d@ -f2 | tr -d "\"")" && \
  test -n "$BUN_VERSION" && echo "Installing Bun ${BUN_VERSION}" && \
  curl -fsSL https://bun.sh/install | bash -s -- "bun-v${BUN_VERSION}"'

# Set the BUN_INSTALL environment variable
ENV BUN_INSTALL="/root/.bun"

# Set the PATH to include Bun
ENV PATH="$BUN_INSTALL/bin:$PATH"

# Configure Bash with Bun
RUN echo 'export BUN_INSTALL="/root/.bun"' >> ~/.bashrc
RUN echo 'export PATH="$BUN_INSTALL/bin:$PATH"' >> ~/.bashrc

# Copy your project files into the container
COPY . /usr/src/app/

# //////////////////////////////////////////////////////////////////////////////////////////////////////////////////// #

# Set the default shell to bash
SHELL ["/bin/bash", "-lc"]

# //////////////////////////////////////////////////////////////////////////////////////////////////////////////////// #
