{% from "bootstrap/map.jinja" import bootstrap with context %}

{% set pkgs = bootstrap.master.pkgs %}
{% set pip = bootstrap.master.pip %}

install_pkgs:
  pkg.installed:
    - pkgs: {{ pkgs }}

install_pip_pkgs:
  pip.installed:
    - pkgs: {{ pip.pkgs }}

