{% from "dev/map.jinja" import dev with context %}

{% set user = dev.user %}

{% if user %}
ensure_user:
  user.present:
    - name: {{ user.name }}
    - shell: {{ user.shell }}
    - home: {{ user.home }}
    - groups:
    {% for group in user.groups %}
      - {{ group }}
    {% endfor %}
{% endif %}

{% if user.ssh.auth_keys %}
ensure_ssh_key:
  ssh_auth.present:
    - user: {{ user.name }}
    - source: {{ user.ssh.auth_keys }}
    - config: '%h/.ssh/authorized_keys'
{% endif %}
