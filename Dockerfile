#FROM alpine:latest
#FROM golang:1.21
FROM golang:1.21-alpine

#ARG PB_VERSION=0.19.4

RUN apk add --no-cache \
    unzip \
    ca-certificates \
    # this is needed only if you want to use scp to copy later your pb_data locally
    openssh

# RUN apk add --no-cache libc6-compat 

# download and unzip PocketBase
# ADD https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip /tmp/pb.zip
# RUN unzip /tmp/pb.zip -d /pb/

# uncomment to copy the local pb_migrations dir into the container
# COPY ./pb_migrations /pb/pb_migrations

# uncomment to copy the local pb_hooks dir into the container
# COPY ./pb_hooks /pb/pb_hooks

WORKDIR /pb

COPY . .

# RUN echo $(ls -1 .)

EXPOSE 8080

# start PocketBase
CMD ["/pb/ticketor", "serve", "--http=0.0.0.0:8080"]
