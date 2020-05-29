# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "system/map.jinja" import system with context %}

{% set pkgs = system.pkgs %}
{% set files = system.files %}

install-system-pkgs:
  pkg.installed:
    - pkgs: {{ pkgs }}

include:
  - .users
  - .ssh
  - .sudoers
  - .firewall

install-system-files:
  file.managed:
    - user: 'root'
    - group: 'root'
    - mode: '0600'
    - makedirs: True
    - names:
    {%- for file in files %}
      - {{ file.dest }}:
        - source: {{ file.src }}
    {%- endfor %}

