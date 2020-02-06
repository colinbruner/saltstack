{% from "dotfiles/map.jinja" import dotfiles with context %}

{% set pip = dotfiles.pip %}
{% set pkgs = dotfiles.pkgs %}

{% if pkgs %}
install_dotfile_pkgs:
  pkg.installed:
    - pkgs: {{ pkgs }}
{% endif %}

{% if pip.pkgs %}
install_dotfile_pip_pkgs:
  pip.installed:
    - pkgs: {{ pip.pkgs }}
{% endif %}
