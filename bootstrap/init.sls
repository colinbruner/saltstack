{% set config = bootstrap.minion.config %}

{% if salt['grains.get']('is_saltmaster') == True %}
include:
  - master
{% endif %}

{#
# Unnecessary 
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
