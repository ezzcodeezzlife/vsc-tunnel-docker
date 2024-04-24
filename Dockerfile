# Use the latest Ubuntu image as a base
FROM ubuntu:latest

# Update the system and install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    tar \
    git \
    vim \
    wget \
    unzip \
    build-essential \
    software-properties-common

# Clean up APT when done to reduce image size
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Create a directory for the VS Code CLI
RUN mkdir /vscode-cli

# Download and unpack the VS Code CLI
RUN curl -Lk 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' --output vscode_cli.tar.gz
RUN tar -xf vscode_cli.tar.gz -C /vscode-cli

# Set the working directory to the unpacked CLI
WORKDIR /vscode-cli

# Define a volume for persistent data
VOLUME /vscode-cli/data

# Start the VS Code Server and create a tunnel
CMD ["./code", "tunnel", "--accept-server-license-terms"]