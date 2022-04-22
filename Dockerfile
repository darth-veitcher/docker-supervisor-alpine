ARG TZ='Europe/London'
FROM alpine

# BUILD
# Add supervisor and postfix
RUN \
    set -x && \
    apk add --no-cache \
        supervisor \
        postfix \
        && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /var/log/supervisor && \
    mkdir -p /etc/supervisor/conf.d

# supervisor base configuration
RUN mv /etc/supervisor/supervisord.conf /etc/supervisor/supervisord.conf.bak || true
ADD configs/supervisord.conf /etc/supervisor/supervisord.conf

# PORTS
EXPOSE 9001

# STARTUP
# default initialisation command
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]