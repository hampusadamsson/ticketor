#FROM alpine:latest
#FROM golang:1.21
FROM golang:1.21-alpine

#ARG PB_VERSION=0.19.4

RUN apk add --no-cache \
    bash \
    git \
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

# ADD https://github.com/hampusadamsson/ticketor/zipball/master/ /tmp/ticketor.zip
# RUN unzip /tmp/ticketor.zip -d /pb/
RUN git clone https://github.com/hampusadamsson/ticketor.git
WORKDIR /pb/ticketor/


#COPY . .

RUN echo $(ls -1)
# RUN echo $(ls -1 /pb/hampusadamsson-ticketor-75f95e3)

# WORKDIR /pb/hampusadamsson-ticketor-75f95e3/

RUN CGO_ENABLED=0 GOOS=linux go build -o /pb/binary .

EXPOSE 8080

# start PocketBase
CMD ["/pb/binary", "serve", "--http=0.0.0.0:8080"]
