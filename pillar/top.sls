---

base:
  '*':
    - common.smtp
    - common.schedule

  # Salt and Pepper hosts
  'salt*':
    - host.salt
  'pepper*':
    - host.pepper

  'G@os_family:RedHat':
    - os.RedHat

  'G@saltmaster:True':
    - saltmaster

