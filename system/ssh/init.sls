{% from "system/map.jinja" import system with context %}

{% set ssh = system.sshd_config %}

# Update sshd_config
{% for line in ssh.replace %}
update_sshd_config_{{ line.new }}:
 file.replace:
   - name: {{ ssh.file }}
     pattern: {{ line.old }}
     repl: {{ line.new }}
{% endfor %}

ensure_sshd_running:
  service.running:
    - name: sshd
      enable: True
    - watch:
      - file: {{ ssh.file }} 
