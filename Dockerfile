FROM debian:bookworm
RUN useradd -u 1000 -m server
RUN apt-get update && apt-get install -y curl software-properties-common gnupg  && \
    apt-get clean

# Import the Nodesource GPG key
RUN apt-get update && \
    apt-get install -y ca-certificates curl gnupg && \
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg



# Create deb repository for a specific Node major version
ARG NODE_MAJOR=18
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" > /etc/apt/sources.list.d/nodesource.list

# Update and install Node.js
RUN apt-get update && apt-get install -y nodejs

WORKDIR /home/server
COPY . examples/nodejs-simple
RUN cd examples/nodejs-simple && \
    npm ci --production
RUN chown -R server /home/server
USER 1000
EXPOSE 5000 9358/tcp 9358/udp
WORKDIR /home/server/examples/nodejs-simple
ENTRYPOINT ["npm", "start", "--"]
