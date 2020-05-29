# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "system/map.jinja" import system with context %}

{% set user = system.user.name | default('cbruner') %}

install-nopasswd-user:
  file.managed:
    - name: /etc/sudoers.d/90-{{ user }}-user
    - user: root
    - group: root
    - mode: 0440
    - source: salt://system/files/sudoers.d/nopasswd-user.j2
    - template: jinja
    - defaults:
        user: {{ user }}
