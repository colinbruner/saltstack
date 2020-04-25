{% from "system/map.jinja" import system with context %}

{% set sudoers = system.sudoers %}

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

