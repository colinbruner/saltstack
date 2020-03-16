base:
  'salt*':
    - saltmaster

  '*':
    - schedule
    - secrets
    - smtp
