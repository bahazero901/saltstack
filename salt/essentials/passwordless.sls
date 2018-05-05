/etc/sudoers:
  file.managed:
    - source: salt://essentials/files/sudoers
    - user: root
    - group: root
    - mode: 440
