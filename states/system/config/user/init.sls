# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "system/map.jinja" import system with context %}

{% set user = system.user %}

install-user:
  user.present:
    - name: {{ user.name }}
    - shell: {{ user.shell | default('/bin/bash') }}
    - home: {{ user.home }}
  {% if user.groups | default(None) %}
    - groups:
    {% for group in user.groups %}
      - {{ group }}
    {% endfor %}
  {% endif %}

{% set ssh = user.ssh %}

{% if ssh.auth_keys | default(False) %}
install-ssh-key:
  ssh_auth.present:
    - user: {{ user.name }}
    - source: {{ ssh.auth_keys }}
    - config: '%h/.ssh/authorized_keys'
{% endif %}

# Include raspberry pi specifics
{% if salt['grains.get']('osarch') == 'armhf' %}
include:
  - .raspberrypi
{% endif %}
