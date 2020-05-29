# -*- coding: utf-8 -*-
# vim: ft=sls

enable-salt-master:
  service.running:
    - name: salt-master
      enable: True
