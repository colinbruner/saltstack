# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "saltmaster/map.jinja" import master with context %}

install-master-config:
  file.managed:
    - name: /etc/salt/master
    - source: {{ master.config.file }}
    - user: 'root'
    - group: 'root'
    - mode: '0600'
    - makedirs: True
