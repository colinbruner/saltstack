---

{% if salt['grains.get']('os_family') == 'RedHat' %}
include:
  - .zones
  - .service
{% endif %}
