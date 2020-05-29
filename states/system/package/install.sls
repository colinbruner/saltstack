# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "system/map.jinja" import system with context %}

{% set pkgs = system.pkgs %}

{% if pkgs %}
install-system-pkgs:
  pkg.installed:
    - pkgs: {{ pkgs }}
{% else %}
no-system-pkgs-to-install:
  test.nop: []
{% endif %}
