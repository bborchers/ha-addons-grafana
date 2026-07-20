#!/usr/bin/with-contenv bashio
# ==============================================================================
# Starts the Grafana add-on
# ==============================================================================

bashio::log.info "Starting Grafana..."

LOG_LEVEL=$(bashio::config 'log_level')
ADMIN_USER=$(bashio::config 'admin_user')
ADMIN_PASSWORD=$(bashio::config 'admin_password')
ANONYMOUS_ACCESS=$(bashio::config 'anonymous_access')

# Store persistent data in the add-on data directory
mkdir -p /data/grafana/data /data/grafana/logs /data/grafana/plugins

export GF_PATHS_HOME="/opt/grafana"
export GF_PATHS_DATA="/data/grafana/data"
export GF_PATHS_LOGS="/data/grafana/logs"
export GF_PATHS_PLUGINS="/data/grafana/plugins"
export GF_PATHS_PROVISIONING="/opt/grafana/conf/provisioning"
export GF_SERVER_HTTP_PORT="3000"
export GF_LOG_LEVEL="${LOG_LEVEL}"
export GF_SECURITY_ADMIN_USER="${ADMIN_USER}"
export GF_SECURITY_ADMIN_PASSWORD="${ADMIN_PASSWORD}"
export GF_AUTH_ANONYMOUS_ENABLED="${ANONYMOUS_ACCESS}"

if bashio::config.has_value 'root_url'; then
    export GF_SERVER_ROOT_URL="$(bashio::config 'root_url')"
fi

if bashio::config.has_value 'domain'; then
    export GF_SERVER_DOMAIN="$(bashio::config 'domain')"
fi

if bashio::config.true 'ssl'; then
    CERTFILE=$(bashio::config 'certfile')
    KEYFILE=$(bashio::config 'keyfile')
    export GF_SERVER_PROTOCOL="https"
    export GF_SERVER_CERT_FILE="/ssl/${CERTFILE}"
    export GF_SERVER_CERT_KEY="/ssl/${KEYFILE}"
fi

SMTP_ENABLED=$(bashio::config 'smtp_enabled')
export GF_SMTP_ENABLED="${SMTP_ENABLED}"

if bashio::config.has_value 'smtp_host'; then
    export GF_SMTP_HOST="$(bashio::config 'smtp_host')"
fi

if bashio::config.has_value 'smtp_user'; then
    export GF_SMTP_USER="$(bashio::config 'smtp_user')"
fi

if bashio::config.has_value 'smtp_password'; then
    export GF_SMTP_PASSWORD="$(bashio::config 'smtp_password')"
fi

if bashio::config.has_value 'smtp_from_address'; then
    export GF_SMTP_FROM_ADDRESS="$(bashio::config 'smtp_from_address')"
fi

if bashio::config.has_value 'smtp_from_name'; then
    export GF_SMTP_FROM_NAME="$(bashio::config 'smtp_from_name')"
fi

if bashio::config.has_value 'smtp_skip_verify'; then
    export GF_SMTP_SKIP_VERIFY="$(bashio::config 'smtp_skip_verify')"
fi

if bashio::config.has_value 'smtp_starttls_policy'; then
    export GF_SMTP_STARTTLS_POLICY="$(bashio::config 'smtp_starttls_policy')"
fi

bashio::log.info "Log level: ${LOG_LEVEL}"
bashio::log.info "Admin user: ${ADMIN_USER}"

if bashio::services.available "core"; then
    bashio::log.info "Home Assistant Core API reachable."
fi

cd /opt/grafana || bashio::exit.nok "Grafana installation directory not found."

exec ./bin/grafana server \
    --homepath=/opt/grafana \
    --config=/opt/grafana/conf/defaults.ini
