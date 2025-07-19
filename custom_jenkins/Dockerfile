# Use the official Jenkins LTS image as the base image
# This image includes Jenkins installed and preconfigured with best practices
FROM jenkins/jenkins:lts

# Switch to root user to install system-level dependencies
# The default user is 'jenkins', but root access is needed to install Docker and other packages
USER root

# Install required packages and Docker engine inside the Jenkins container
RUN apt-get update -y && \
    apt-get install -y apt-transport-https \
                       ca-certificates \
                       curl \
                       gnupg \
                       software-properties-common && \
    \
    # Add Docker’s official GPG key
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    \
    # Add Docker’s stable repository to APT sources
    echo "deb [arch=amd64] https://download.docker.com/linux/debian bullseye stable" > /etc/apt/sources.list.d/docker.list && \
    \
    # Update package index again to include Docker packages
    apt-get update -y && \
    \
    # Install Docker CE (Community Edition), CLI, and container runtime
    apt-get install -y docker-ce docker-ce-cli containerd.io && \
    \
    # Clean up APT cache to reduce image size
    apt-get clean

# Ensure the 'docker' group exists (create if missing), and add 'jenkins' user to it
# This allows the Jenkins user to execute Docker commands without needing root
RUN groupadd -f docker && \
    usermod -aG docker jenkins

# Create a persistent Docker volume directory to support Docker-in-Docker (DinD)
# This ensures Docker layer caching and container runtime can persist as needed
RUN mkdir -p /var/lib/docker
VOLUME /var/lib/docker

# Switch back to the non-root Jenkins user for security and to match Jenkins default behavior
USER jenkins