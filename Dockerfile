FROM scratch
LABEL maintainer="patrickfdomnick@gmail.com"

# Copy from Dist
ARG PLATFORM
COPY dist/${PLATFORM}/gin-vals /

# Expose Port and run Server
EXPOSE 9090/tcp
ENTRYPOINT ["/gin-vals"]
