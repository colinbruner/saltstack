{% from "minion/map.jinja" import minion with context %}

{% set config = minion.config %}

install-minion-config:
  file.managed:
    - name: /etc/salt/minion
    - source: {{ config.file }}
    - user: 'root'
    - group: 'root'
    - mode: '0644'
    - makedirs: True

