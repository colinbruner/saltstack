{% from "bootstrap/map.jinja" import bootstrap with context %}

{% set pkgs = bootstrap.master.pkgs %}
{% set pip = bootstrap.master.pip %}

install_saltmaster_pkgs:
  pkg.installed:
    - pkgs: {{ pkgs }}

install_saltmatser_pip_pkgs:
  pip.installed:
    - pkgs: {{ pip.pkgs }}

