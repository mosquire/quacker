# Start from official Ubuntu image
FROM ubuntu:22.04

ARG QUARTO_VERSION=1.4.37
ARG DEBIAN_FRONTEND=noninteractive

# Install Ubuntu dependencies
RUN apt-get update
RUN apt-get install -y \
    curl \
    python3 \
    r-base \
    fonts-open-sans

# Download quarto
RUN curl -o quarto-${QUARTO_VERSION}-linux-amd64.deb -L https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb
RUN curl -o checksums.txt -L https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-checksums.txt
RUN sha256sum -c checksums.txt --ignore-missing

# Install quarto
RUN dpkg -i quarto-${QUARTO_VERSION}-linux-amd64.deb

# clean up files
RUN rm checksums.txt
RUN rm quarto-${QUARTO_VERSION}-linux-amd64.deb
RUN quarto install tinytex