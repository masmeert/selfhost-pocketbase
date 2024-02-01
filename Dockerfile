FROM alpine:latest

ARG PB_VERSION=0.19.2

RUN apk add --no-cache \
  unzip \
  ca-certificates

ADD https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /app/pocketbase/ && \
  chmod +x /app/pocketbase/pocketbase && \
  rm -rf /tmp/pb.zip

# COPY ./apps/pocketbase/pb_migrations /pb/pb_migrations
# COPY ./pocketbase/pb_hooks /pb/pb_hooks

EXPOSE 8090

# start PocketBase
CMD ["/app/pocketbase/pocketbase", "serve", "--http=0.0.0.0:8090", "--dir=/app/data/pb_data", "--publicDir=/app/data/pb_public"]
