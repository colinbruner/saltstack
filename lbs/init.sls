{% from "lbs/map.jinja" import lbs with context %}

# https://github.com/saltstack/salt/issues/52681#issuecomment-490511548
{% set key = salt['pillar.get']('secrets:lbs:key')|json %}
{% set cert = salt['pillar.get']('secrets:lbs:cert')|json %}

install_lb:
  pkg.installed:
    - pkgs: {{ lbs.pkgs }}

install_config:
  file.managed:
    - name: {{ lbs.config.path }}
      source: salt://lbs/files/default.conf
      makedirs: True

{% if key %}
install_key:
  file.managed:
    - name: {{ lbs.key.path }}
      contents: {{ key }}
      makedirs: True
{% endif %}

{% if cert %}
install_cert:
  file.managed:
    - name: {{ lbs.cert.path }}
      contents: {{ cert }}
      makedirs: True
{% endif %}

enable_lb:
  service.running:
    - name: {{ lbs.service }}
      enable: True
    - watch: 
      - file: install_config

