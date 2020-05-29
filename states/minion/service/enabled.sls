# -*- coding: utf-8 -*-
# vim: ft=sls

start-salt-master:
  service.running:
    - name: salt-minion
      enable: True
