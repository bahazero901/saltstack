include:
  - essentials.passwordless

centos-user:
  user.present:
    - name: centos
    - home: /home/centos
    - uid: 1100

centos-group:
  group.present:
    - name: centos
    - addusers:
      - centos

/home/centos/.ssh/:
  file.directory:
    - user: centos
    - group: centos
    - dir_mode: 700
    - require:
      - user: centos-user
      - group: centos-group

#need to get password to work
/home/centos/.ssh/authorized_keys:
  file.managed:
    - source: salt://essentials/files/authorized_keys
    - user: root
    - group: root
    - mode: 600
    - require:
      - file: /home/centos/.ssh/

