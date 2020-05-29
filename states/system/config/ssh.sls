# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "system/map.jinja" import system with context %}

{% set ssh = system.sshd_config %}

install-sshd-config:
 file.managed:
   - name: /etc/ssh/sshd_config
   - source: salt://system/files/ssh/sshd_config
   - user: root
   - group: root
   - mode: 0600
   - template: jinja

start-sshd-running:
  service.running:
    - name: sshd
      enable: True
    - watch:
      - file: install-sshd-config
