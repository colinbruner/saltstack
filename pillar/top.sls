
base:
  '*':
    - common.smtp
    - common.schedule

  # Match by hostname
  'salt':
    - host.salt
  'pepper':
    - host.pepper

  # role specific
  'G@role:saltmaster':
    - role.saltmaster
