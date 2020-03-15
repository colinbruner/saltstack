{% from "system/map.jinja" import system with context %}

{% set pkgs = system.pkgs %}
{% set sshd = system.sshd_config %}
{% set files = system.files %}
{% set sudoers = system.sudoers %}

install_system_pkgs:
  pkg.installed:
    - pkgs: {{ pkgs }}

{% if salt['grains.get']('os_family') == 'RedHat' %}
include:
  - .firewalld
{% endif %}

install_system_files:
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

{% if sudoers.uncomment %}
uncomment_sudoers:
  file.uncomment:
    - name: "/etc/sudoers"
      regex: "{{ sudoers.uncomment }}"
{% endif %}

{% if sudoers.comment %}
add_comment_sudoers:
  file.append:
    - name: "/etc/sudoers"
      text: 
        - "{{ sudoers.comment }}"
{% endif %}

{% for line in sshd.replace %}
update_sshd_{{ line.new }}:
 file.replace:
   - name: {{ sshd.file }}
     pattern: {{ line.old }}
     repl: {{ line.new }}
{% endfor %}

ensure_sshd_running:
  service.running:
    - name: sshd
      enable: True
    - watch:
      - file: {{ sshd.file }} 
