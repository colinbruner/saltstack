# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "haproxy/map.jinja" import haproxy with context %}

# {{ haproxy }}
install-haproxy-config:
  file.managed:
    - name: /etc/haproxy/haproxy.cfg
      source: {{ haproxy.file }}
      user: 'root'
      group: 'root'
      mode: 0644
      makedirs: True
      template: jinja
      defaults:
        config: {{ haproxy.config | yaml() }}
