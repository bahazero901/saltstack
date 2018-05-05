- include:
  - common.etcd

etcd-service:
  service.running:
    enable: True
  - require:
    - pkg: etcd-pkgs
  - watch:
    - file: /etc/etcd/etcd.conf

/etc/etcd/etcd.conf:
  file.managed:
    - source: salt://etcd/files/etcd.conf
    - user: keystone
    - group: keystone
    - mode: 640
    - template: jinja
    - require:
      - pkg: etcd-pkgs