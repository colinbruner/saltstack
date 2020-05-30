# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "haproxy/map.jinja" import haproxy with context %}

install-haproxy-pkgs:
  pkg.installed:
    - pkgs: {{ haproxy.pkgs }}
