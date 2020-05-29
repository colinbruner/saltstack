# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "system/map.jinja" import system with context %}

{% set ssh = system.sshd_config %}

# Update sshd_config
{% for line in ssh.replace %}
update-sshd-config-{{ line.new }}:
 file.replace:
   - name: {{ ssh.file }}
     pattern: {{ line.old }}
     repl: {{ line.new }}
{% endfor %}

ensure-sshd-running:
  service.running:
    - name: sshd
      enable: True
    - watch:
      - file: {{ ssh.file }} 
