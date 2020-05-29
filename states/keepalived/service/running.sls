# -*- coding: utf-8 -*-
# vim: ft=sls

enable-keepalived-service:
  service.running:
    - name: keepalived
      enable: True
    - watch:
      - file: /etc/keepalived/keepalived.conf


