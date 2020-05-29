# -*- coding: utf-8 -*-
# vim: ft=sls

{% if salt['pillar.get']('keepalived', {}).get('config', {}).get('state', None) %}
include:
  - .package
  - .config
  - .service
{% else %}
keepalived-pillar-not-configured:
  test.nop: []
{% endif %}

