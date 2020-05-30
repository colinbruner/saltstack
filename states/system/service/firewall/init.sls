# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "system/map.jinja" import system with context %}

{% set firewall = system.firewall %}

# {{ firewall }}

{% if salt['grains.get']('os_family') == 'RedHat' %}
include:
  - .zones
  - .service
{% endif %}
