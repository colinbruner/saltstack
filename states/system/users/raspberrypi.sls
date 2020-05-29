# -*- coding: utf-8 -*-
# vim: ft=sls

remove-pi-user:
  user.absent:
    - name: pi
      purge: true
    - require:
      - user: install-user
      - ssh_auth: install-ssh-key

