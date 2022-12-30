FROM phusion/baseimage:jammy-1.0.1

RUN apt-get update && apt-get install -y \
    davfs2 libreoffice python3-doit cron \
    && rm -rf /var/lib/apt/lists/*

RUN rm -rf /etc/cron.*/*

COPY fonts/* /usr/local/share/fonts
COPY entrypoint.sh dodo.py /opt
ARG DAV_CA_CERT_NAME
RUN echo "delay_upload 0" >> /etc/davfs2/davfs2.conf && \
    echo "trust_ca_cert ${DAV_CA_CERT_NAME}" >> /etc/davfs2/davfs2.conf
WORKDIR /opt 
#ENTRYPOINT ["/usr/bin/bash", "-c", "./entrypoint.sh"]
ENTRYPOINT ["./entrypoint.sh"]

