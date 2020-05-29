# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "system/map.jinja" import system with context %}

{% set firewall = system.firewall %}

{% for zone in firewall.zones %}
manage-{{ zone.name }}-zone:
  firewalld.present:
    - name: {{ zone.name }}
    {% if zone.services | default(False) %}
    - services:
      {% for service in zone.services %}
      - {{ service }}
      {% endfor %}
    {% endif %}
    {% if zone.ports | default(False) %}
    - ports:
      {% for port in zone.ports %}
      - {{ port }}
      {% endfor %}
    {% endif %}
{% endfor %}

