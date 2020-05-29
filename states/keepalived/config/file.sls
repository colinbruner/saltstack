# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "keepalived/map.jinja" import keepalived with context %}

install-keepalived-config:
  file.managed:
    - name: /etc/keepalived/keepalived.conf
    - source: salt://keepalived/files/keepalived.conf.j2
    - user: 'root'
    - group: 'root'
    - mode: '0644'
    - makedirs: True
    - template: jinja
    - defaults:
        keepalived: {{ keepalived | yaml() }}
