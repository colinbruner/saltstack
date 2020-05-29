# -*- coding: utf-8 -*-
# vim: ft=sls

restart-salt-minion:
  cmd.run:
    - name: 'salt-call service.restart salt-minion'
    - bg: True
    - order: last
    - onchanges:
      - file: /etc/salt/minion

