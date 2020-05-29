# -*- coding: utf-8 -*-
# vim: ft=sls

start-firewalld-running:
  service.running:
    - name: firewalld
      enable: True
