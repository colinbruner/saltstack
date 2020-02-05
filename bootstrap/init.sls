{% from "bootstrap/map.jinja" import bootstrap with context %}

{% set pkgs = bootstrap.pkgs %}
{% set pip = bootstrap.pip %}
{% set master_config = bootstrap.files.master_config %}

install_pkgs:
  pkg.installed:
    - pkgs: {{ pkgs }}

install_pip_pkgs:
  pip.installed:
    - pkgs: {{ pip.pkgs }}

install_master_config:
  file.managed:
    - name: {{ master_config.dest }}
    - source: {{ master_config.src }}
    - user: 'root'
    - group: 'root'
    - mode: '0600'
    - makedirs: True

start_salt_minion:
  service.running:
    - name: salt-minion
      enable: True

start_salt_master:
  service.running:
    - name: salt-master
      enable: True
    - watch:
      - file: {{ master_config.dest }} 
