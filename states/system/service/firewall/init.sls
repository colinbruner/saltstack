# -*- coding: utf-8 -*-
# vim: ft=sls 
{% from "system/map.jinja" import system with context %}

{% set firewall = system.firewall | default(None) %}

{% if firewall and salt['grains.get']('os_family') == 'RedHat' %}
include:
  - .service
  - .zones
{% endif %}
