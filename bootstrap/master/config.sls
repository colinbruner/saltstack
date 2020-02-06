{% set config = bootstrap.master.config %}

install_master_config:
  file.managed:
    - name: {{ config.dest }}
    - source: {{ config.src }}
    - user: 'root'
    - group: 'root'
    - mode: '0600'
    - makedirs: True
