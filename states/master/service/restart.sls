# -*- coding: utf-8 -*-
# vim: ft=sls

restart-salt-master:
  cmd.run:
    - name: 'salt-call service.restart salt-master'
    - bg: True
    - order: last
    - onchanges:
      - file: /etc/salt/master

