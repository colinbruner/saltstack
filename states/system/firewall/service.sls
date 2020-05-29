# -*- coding: utf-8 -*-
# vim: ft=sls

ensure-firewalld-running:
  service.running:
    - name: firewalld
      enable: True
