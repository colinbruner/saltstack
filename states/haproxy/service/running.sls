# -*- coding: utf-8 -*-
# vim: ft=sls

enable-haproxy-service:
  service.running:
    - name: haproxy
      enable: True
    - watch: 
      - file: /etc/haproxy/haproxy.cfg

