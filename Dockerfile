FROM debian:buster-slim AS builder

ARG VERSION=v1.18.3

WORKDIR /tmp
RUN apt-get update && apt-get install -y curl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/${VERSION}/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl

FROM alpine:latest
RUN apk --no-cache add ca-certificates
COPY --from=builder /tmp/kubectl /usr/bin/
ENTRYPOINT [ "kubectl" ]
