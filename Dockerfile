##############################
## Build dev relay
##############################
FROM rust:latest AS rust-builder

RUN update-ca-certificates

# Pull a fork of chorus
RUN git clone -b latest https://github.com/BitcreditProtocol/chorus.git

WORKDIR /chorus

RUN cargo build --release

##############################
## Create dev image for docker compose
##############################
FROM ubuntu:22.04

RUN apt-get update && \
  apt-get install -y ca-certificates && \
  apt-get clean

WORKDIR /relay

# This data directory is used for the relay to store its data and can be
# mounted to a persistent volume.
RUN mkdir data

# Copy a default config file
COPY ./config.toml ./

# Copy binary release
COPY --from=rust-builder /chorus/target/release/chorus ./chorus

RUN chmod +x /relay/chorus

# Expose websocket port
EXPOSE 8080

CMD ["/relay/chorus", "./config.toml"]
