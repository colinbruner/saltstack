{% from "dotfiles/map.jinja" import dotfiles with context %}

{% set user = dotfiles.user %}
{% set nvim = dotfiles.app.nvim %}

include:
  - .pkgs
  - .user
  - .configs

{% if nvim %}
# Install nvim from app image
install_nvim:
  file.managed:
    - name: {{ nvim.dest }}
    - user: root
    - group: root
    - mode: '0755'
    - source: {{ nvim.src }}
    - source_hash: {{ nvim.source_hash }}

# output is rather ugly, but command does work
install_nvim_pluggins:
  cmd.run:
    - name: "/usr/bin/nvim +VimEnter +PlugInstall +qal"
    - runas: {{ user.name }}
    - creates: {{ user.home }}/.vim/plugged

{% endif %}

# Link python3 -> python on RedHat/CentOS 8 systems
{% if grains['os_family'] == 'RedHat' and grains['osrelease'] == '8' %}
python3_symlink:
  file.symlink:
    - name: /usr/bin/python
    - target: /usr/bin/python3
    - user: root
    - group: root
    - mode: 0755
{% endif %}

