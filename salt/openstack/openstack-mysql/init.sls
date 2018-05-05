require:
  - mysql

{% set root_pass = salt['pillar.get']('mysql:root_password') -%}

python-mysql:
  pkg.installed:
    - name:
      - python2-PyMySQL
    - require:
      - pkg: mysql-pkgs

mariadb-services:
  service.running:
    enable: True
    - require:
      - pkg: mysql-pkgs
    - watch:
      - file: /etc/my.cnf.d/openstack.cnf

/etc/my.cnf.d/openstack.cnf:
  file.managed:
    - source: salt://mysql/files/openstack.cnf
    - owner: root
    - group: root
    - template: jinja
    - require:
      - pkg: mysql-pkgs



