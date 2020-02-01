{% from "dev/map.jinja" import dev with context %}

{% set pip = dev.pip %}
{% set pkgs = dev.pkgs %}

{% if pkgs %}
install_pkgs:
  pkg.installed:
    - pkgs: {{ pkgs }}
{% endif %}

{% if pip.pkgs %}
install_pip_pkgs:
  pip.installed:
    - pkgs: {{ pip.pkgs }}
{% endif %}
