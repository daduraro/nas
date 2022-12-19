# OMV configuration

OMV uses `postfix` service for its notification system, which by default listens to port 25. In order to change that (so that the mail server can bind to port 25 and have a standard configuration), we need to configure OMV using its `omv-salt` utils (https://github.com/openmediavault/openmediavault-docs/blob/79d46f2ee75a4e964659d09bfbab652c116c8d0c/various/advset.rst ).

This means, creating the file `/srv/salt/omv/deply/postfix/21customport.sls` with contents:

```yaml
custom_port_postfix_master:
  file.replace:
    - name: "/etc/postfix/master.cf"
    - pattern: "^smtp"
    - repl: "2525"
    - count: 1
```

then execute

```console
# omv-salt deploy run postfix
# systemctl restart postfix
```

We can then verify there is no program binding on port 25 using

```console
# netstat -ltnp
```
