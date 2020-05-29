# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "saltmaster/map.jinja" import master with context %}

install-saltmaster-pkgs:
  pkg.installed:
    - pkgs: 
    {% for pkg in master.pkgs %}
      - {{ pkgs }}
    {% endfor %}

install-saltmaster-pip-pkgs:
  pip.installed:
    - pkgs: 
    {% for pkg in master.pip %}
      - {{ pkgs }}
    {% endfor %}

