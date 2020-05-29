{% from 'beacons/map.jinja' import beacons_conf with context %}


{% for beacon_module,  config in beacons_conf.items() %}
{{ beacon_module }}:
  beacon.present: {{ config }}
{% endfor %}
