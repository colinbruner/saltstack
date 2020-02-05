{% from "bootstrap/map.jinja" import bootstrap with context %}

{% set pkgs = bootstrap.pkgs %}
{% set pip = bootstrap.pip %}
{% set master_config = bootstrap.files.master_config %}

{% if salt['grains.get']('os') == 'CentOS' %}
# Statically configure required CentOS repo to install libgit2-devel
enable_PowerTools_repo:
  pkgrepo.managed:
    - name: PowerTools
    - humanname: CentOS-$releasever - PowerTools
    - mirrorlist: http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=PowerTools&infra=$infra
    - gpgcheck: 1
    - enabled: 1
    - gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
{% endif %}

install_pkgs:
  pkg.installed:
    - pkgs: {{ pkgs }}

install_pip_pkgs:
  pip.installed:
    - pkgs: {{ pip.pkgs }}

install_master_config:
  file.managed:
    - name: {{ master_config.dest }}
    - source: {{ master_config.src }}
    - user: 'root'
    - group: 'root'
    - mode: '0600'
    - makedirs: True

start_salt_minion:
  service.running:
    - name: salt-minion
      enable: True

start_salt_master:
  service.running:
    - name: salt-master
      enable: True
    - watch:
      - file: {{ master_config.dest }} 
