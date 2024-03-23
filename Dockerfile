# Use the latest Ubuntu image as a base
FROM ubuntu:latest

# Update the system and install necessary packages
RUN apt-get update && apt-get install -y curl tar git vim

# Copy the script file from your host to the container
##COPY install_packages.sh /tmp/

# Execute the script
##RUN chmod +x /tmp/install_packages.sh && /tmp/install_packages.sh

# Create a directory for the VS Code CLI
RUN mkdir /vscode-cli

# Download and unpack the VS Code CLI
RUN curl -Lk 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' --output vscode_cli.tar.gz
RUN tar -xf vscode_cli.tar.gz -C /vscode-cli

# Set the working directory to the unpacked CLI
WORKDIR /vscode-cli

# Start the VS Code Server and create a tunnel
CMD ["./code", "tunnel", "--accept-server-license-terms"]