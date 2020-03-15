{% from "bootstrap/map.jinja" import bootstrap with context %}

{% set config = bootstrap.minion.config %}

{#
{% if salt['pillar.get']('is_saltmaster', False) %}
include:
  - .master
{% endif %}

# Unnecessary, using out of the box minion cfg.
install_minion_config:
  file.managed:
    - name: {{ config.dest }}
    - source: {{ config.src }}
    - user: 'root'
    - group: 'root'
    - mode: '0600'
    - makedirs: True
#}

start_salt_minion:
  service.running:
    - name: salt-minion
      enable: True
