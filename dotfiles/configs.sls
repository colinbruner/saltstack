{% from "dotfiles/map.jinja" import dotfiles with context %}

{% set user = dotfiles.user %}
{% set config = dotfiles.files.configs %}

{% if config.files %}
# All files are installed with implicit user home directory prepend
install_config_files:
  file.managed:
    - user: {{ user.name }}
    - group: {{ user.name }}
    - mode: '0644'
    - names:
    {% for file in config.files %}
      - {{ user.home }}/{{ file.dest }}:
        - source: {{ file.src }}
    {% endfor %}
{% endif %}

{% if config.dirs %}
  {% for dir in config.dirs %}
# All files are installed with implicit user home directory prepend
install_config_dir_{{ dir.dest }}:
  file.recurse:
    - name: {{ user.home }}/{{ dir.dest }}
    - user: {{ user.name }}
    - group: {{ user.name }}
    - dir_mode: '0755'
    - file_mode: '0644'
    - source: {{ dir.src }}
  {% endfor %}
{% endif %}


