---

base:
  '*':
    - smtp
    - schedule

  'G@os_family:RedHat':
    - os.RedHat

  'G@saltmaster:True':
    - saltmaster

