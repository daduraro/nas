FROM phusion/baseimage:jammy-1.0.1

RUN apt-get update && apt-get install -y \
    davfs2 libreoffice python3-doit \
    && rm -rf /var/lib/apt/lists/*

COPY fonts/* /usr/local/share/fonts
COPY entrypoint.sh dodo.py /opt
RUN echo "delay_upload 0" >> /etc/davfs2/davfs2.conf
WORKDIR /opt 
ENTRYPOINT ["/usr/bin/bash", "-c", "./entrypoint.sh"]

