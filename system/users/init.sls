{% from "system/map.jinja" import system with context %}

{% set users = system.users %}

{% for user in users %}
ensure_user_{{ user.name }}:
  user.present:
    - name: {{ user.name }}
    - shell: {{ user.shell | default('/bin/zsh') }}
    - home: {{ user.home }}
    - groups:
    {% for group in user.groups %}
      - {{ group }}
    {% endfor %}

{% if user.ssh.auth_keys | default(False) %}
install_{{ user.name }}_ssh_key:
  ssh_auth.present:
    - user: {{ user.name }}
    - source: {{ user.ssh.auth_keys }}
    - config: '%h/.ssh/authorized_keys'
{% endif %}
{% endfor %}
