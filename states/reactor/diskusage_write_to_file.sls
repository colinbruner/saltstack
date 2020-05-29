
send_an_alert_email:
  local.state.single:
    - tgt: "{{ data['id'] }}"
    - args:
      - fun: smtp.send_msg
      - name: "This is a diskspace message."
      - profile: "google-smtp-profile"
      - subject: "DiskSpace Alert {{ data['id'] }} on {{ data['mount'] }}"
      - recipient: "colin.d.bruner@gmail.com"
      - sender: "colin.d.bruner@gmail.com"
      - use_ssl: True
      - attachments:
          - /var/log/salt/minion

