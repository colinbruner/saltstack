---

base:
  '*':
    - common.smtp
    - common.schedule

  # Salt and Pepper hosts
  'salt*':
    - salt
  'pepper*':
    - pepper

  'G@os_family:RedHat':
    - os.RedHat

  'G@saltmaster:True':
    - saltmaster

