# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "system/map.jinja" import system with context %}

{% set sudoers = system.sudoers %}

{% if sudoers.uncomment %}
uncomment-sudoers:
  file.uncomment:
    - name: "/etc/sudoers"
      regex: "{{ sudoers.uncomment }}"
{% endif %}

{% if sudoers.comment %}
add-comment-sudoers:
  file.append:
    - name: "/etc/sudoers"
      text: 
        - "{{ sudoers.comment }}"
{% endif %}

