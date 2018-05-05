- include:
  - common.memcached

python-memcached:
  pkgs.installed:
    - require:
      - pkg: memcached-pkgs

service.running:
  - name: memcached
  - require:
    - pkg: memcached-pkgs
  - watch:
    - file: /etc/sysconfig/memcached

/etc/sysconfig/memcached:
  file.managed:
    - source: salt://memcached/files/memcached
    - user: keystone
    - group: keystone
    - mode: 640
    - template: jinja
    - require:
      - pkg: memcached