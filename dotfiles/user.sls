{% from "dotfiles/map.jinja" import dotfiles with context %}

{% set user = dotfiles.user %}
{% set ssh = dotfiles.user.ssh %}

{% if user %}
ensure_user_{{ user.name }}:
  user.present:
    - name: {{ user.name }}
    - shell: {{ user.shell }}
    - home: {{ user.home }}
    - groups:
    {% for group in user.groups %}
      - {{ group }}
    {% endfor %}
{% endif %}

{% if ssh.auth_keys | default(False) %}
install_{{ user.name }}_ssh_key:
  ssh_auth.present:
    - user: {{ user.name }}
    - source: {{ ssh.auth_keys }}
    - config: '%h/.ssh/authorized_keys'
{% endif %}
