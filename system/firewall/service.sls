
ensure_firewalld_running:
  service.running:
    - name: firewalld
      enable: True
