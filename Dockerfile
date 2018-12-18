FROM alpine:3.8

ENV POSTFIX_SMTP_TLS_SECURITY_LEVEL=may
ENV SYSLOG_PATH=-

COPY content /
RUN postfix-setup

VOLUME /var/spool/postfix

ENTRYPOINT ["postfix-entrypoint"]
CMD ["/usr/lib/postfix/master", "-d"]
