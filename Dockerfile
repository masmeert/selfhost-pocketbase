FROM alpine:latest

RUN apk add --no-cache \
    ca-certificates \
    unzip \
    wget \
    zip \
    zlib-dev

ADD https://github.com/pocketbase/pocketbase/releases/download/v0.21.1/pocketbase_0.21.1_linux_amd64.zip /app/pocketbase/pocketbase.zip

RUN unzip /app/pocketbase/pocketbase.zip -d /app/pocketbase && \
    chmod +x /app/pocketbase/pocketbase && \
    rm /app/pocketbase/pocketbase.zip

# COPY ./apps/pocketbase/pb_migrations /pb/pb_migrations
# COPY ./pocketbase/pb_hooks /pb/pb_hooks

EXPOSE 8090

# start PocketBase
CMD ["/app/pocketbase/pocketbase", "serve", "--http=0.0.0.0:8090", "--dir=/app/data/pb_data", "--publicDir=/app/data/pb_public"]
