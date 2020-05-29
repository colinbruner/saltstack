# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "master/map.jinja" import master with context %}

install-master-pkgs:
  pkg.installed:
    - pkgs: 
    {% for pkg in master.pkgs %}
      - {{ pkg }}
    {% endfor %}

install-master-pip-pkgs:
  pip.installed:
    - pkgs: 
    {% for pkg in master.pip %}
      - {{ pkg }}
    {% endfor %}
