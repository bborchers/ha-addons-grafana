ARG BUILD_FROM
FROM ${BUILD_FROM}

# Grafana version (see build.yaml args, can be overridden per build)
ARG GRAFANA_VERSION="13.1.0"
ARG BUILD_ARCH

# Download and install Grafana OSS (musl build, matching the
# Alpine-based hassio-addons base image)
RUN \
    apk add --no-cache \
        ca-certificates \
        curl \
        tzdata \
    && case "${BUILD_ARCH}" in \
        aarch64) GRAFANA_ARCH="arm64" ;; \
        amd64) GRAFANA_ARCH="amd64" ;; \
        *) echo "Unsupported architecture: ${BUILD_ARCH}" >&2 && exit 1 ;; \
    esac \
    && curl -sSfL -o /tmp/grafana.tar.gz \
        "https://dl.grafana.com/oss/release/grafana-${GRAFANA_VERSION}.linux-${GRAFANA_ARCH}-musl.tar.gz" \
    && mkdir -p /opt/grafana \
    && tar -xzf /tmp/grafana.tar.gz -C /opt/grafana --strip-components=1 \
    && rm -f /tmp/grafana.tar.gz

# Custom start script
COPY run.sh /
RUN chmod a+x /run.sh

# Labels (also set via build.yaml, here as fallback/documentation)
LABEL \
    io.hass.name="Grafana" \
    io.hass.description="Grafana analytics and monitoring platform" \
    io.hass.type="addon"

CMD [ "/run.sh" ]
