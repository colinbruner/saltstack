# -*- coding: utf-8 -*-
# vim: ft=sls

# Ensure service is running before issuing update commands
enable-firewalld-service:
  service.running:
    - name: firewalld
    - enable: True
