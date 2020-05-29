# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "system/map.jinja" import system with context %}

{% set files = system.files %}

{% if files %}
install-system-files:
  file.managed:
    - user: 'root'
    - group: 'root'
    - mode: '0644'
    - makedirs: True
    - names:
    {%- for file in files %}
      - {{ file.dest }}:
        - source: {{ file.src }}
    {%- endfor %}
{% else %}
no-system-files-to-install:
  test.nop: []
{% endif %}
