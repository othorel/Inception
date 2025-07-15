ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye-slim}

RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    tar \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN curl -LO https://go.dev/dl/go1.24.5.linux-amd64.tar.gz && \
    rm -rf /usr/local/go && \
    tar -C /usr/local -xzf go1.24.5.linux-amd64.tar.gz && \
    rm go1.24.5.linux-amd64.tar.gz

ENV PATH="/usr/local/go/bin:${PATH}"

RUN git clone https://github.com/jesseduffield/lazydocker.git

WORKDIR /app/lazydocker

ENTRYPOINT [ "bash"]