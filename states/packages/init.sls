# -*- coding: utf-8 -*-
# vim: ft=sls

{% set pkgs = salt['pillar.get']('packages', []) %}

{% if pkgs %}
install-packages:
  pkg.installed:
    - pkgs: {{ pkgs }}
{% else %}
no-packages-to-install:
  test.nop: []
{% endif %}
