FROM cgr.dev/chainguard/static:latest
LABEL maintainer="patrickfdomnick@gmail.com"

ARG PLATFORM
COPY dist/${PLATFORM}/gin-vals /
ENV GIN_MODE="release"

# Expose Port and run Server
EXPOSE 9090/tcp
ENTRYPOINT ["/gin-vals"]
