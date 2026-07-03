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

bashio::log.info "Log level: ${LOG_LEVEL}"
bashio::log.info "Admin user: ${ADMIN_USER}"

if bashio::services.available "core"; then
    bashio::log.info "Home Assistant Core API reachable."
fi

cd /opt/grafana || bashio::exit.nok "Grafana installation directory not found."

exec ./bin/grafana server \
    --homepath=/opt/grafana \
    --config=/opt/grafana/conf/defaults.ini
