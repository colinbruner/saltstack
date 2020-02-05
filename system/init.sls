{% from "system/map.jinja" import system with context %}

{% set pkgs = system.pkgs %}
{% set files = system.files %}
{% set sshd = system.sshd_config %}

install_pkgs:
  pkg.installed:
    - pkgs: {{ pkgs }}

install_files:
  file.managed:
    - user: 'root'
    - group: 'root'
    - mode: '0600'
    - makedirs: True
    - names:
    {%- for file in files %}
      - {{ file.dest }}:
        - source: {{ file.src }}
    {%- endfor %}

{% for line in sshd.replace %}
update_sshd_{{ line.new }}:
 file.replace:
   - name: {{ sshd.file }}
     pattern: {{ line.old }}
     repl: {{ line.new }}
{% endfor %}

restart_ssh:
  service.running:
    - name: sshd
      enable: True
    - watch:
      - file: {{ sshd.file }} 
