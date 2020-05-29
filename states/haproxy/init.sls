# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "haproxy/map.jinja" import haproxy with context %}

install-haproxy:
  pkg.installed:
    - pkgs:
      {% for pkg in haproxy.pkgs %}
      - {{ pkg }}
      {% endfor %}

install-config:
  file.managed:
    - name: /etc/haproxy/haproxy.conf
      source: {{ haproxy.config.file }}
      makedirs: True

enable-service:
  service.running:
    - name: {{ haproxy.service }}
      enable: True
    - watch: 
      - file: install-config

