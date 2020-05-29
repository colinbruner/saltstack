# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "keepalived/map.jinja" import keepalived with context %}

install-keepalived-pkgs:
  pkg.installed:
    - pkgs: {{ keepalived.pkgs }}
