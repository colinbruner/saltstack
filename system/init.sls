{% from "system/map.jinja" import system with context %}

{% set pkgs = system.pkgs %}
{% set files = system.files %}

install_system_pkgs:
  pkg.installed:
    - pkgs: {{ pkgs }}

include:
  - .users
  - .ssh
  - .sudoers
  - .firewall

install_system_files:
  file.managed:
    - user: 'root'
    - group: 'root'
    - mode: '0600'
    - makedirs: True
    - names:
    {%- for file in files %}
      - {{ file.dest }}:
        - source: {{ file.src }}
    {%- endfor %}
