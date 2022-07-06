FROM debian:buster-slim AS certs
RUN apt-get update && apt-get install --no-install-recommends -y ca-certificates && cat /etc/ssl/certs/* > /ca-certificates.crt

FROM scratch
LABEL maintainer="patrickfdomnick@gmail.com"

# Copy from Dist
ARG PLATFORM
COPY dist/${PLATFORM}/gin-vals /
ENV GIN_MODE="release"

# Expose Port and run Server
COPY --from=certs /ca-certificates.crt /ssl/certs/
ENV SSL_CERT_DIR=/ssl/certs
EXPOSE 9090/tcp
ENTRYPOINT ["/gin-vals"]
