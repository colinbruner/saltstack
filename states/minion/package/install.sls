{% from "minion/map.jinja" import minion with context %}

{% if minion.packages | default(None) %}
install-saltminion-pkgs:
  pkg.installed:
    - pkgs: {{ minion.packages }}
{% else %}
no-packages-found-to-install:
  test.nop: []
{% endif %}
