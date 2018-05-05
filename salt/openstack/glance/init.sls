include:
  - common.openstack-pike-repo
  - openstack.mysql
  - openstack.keystone

glance-pkgs:
  pkg.installed:
    - names: openstack-glance
    - require:
      - pkg: pike
      - pkg: keystone-pkgs

/etc/glance/glance-api.conf:
  file.managed:
    - source: salt://glance/files/glance-api.conf
    - user: glance
    - group: glance
    - mode: 640
    - template: jinja
    - require:
      - pkg: glance-pkgs

/etc/glance/glance-registry.conf:
  file.managed:
    - source: salt://openstack/glance/files/glance-registry.conf
    - user: glance
    - group: glance
    - mode: 640
    - template: jinja
    - require:
      - pkg: glance-pkgs

glance_database:
  mysql_database.present:
    - name: glance
    - require:
      - pkg: python-mysql

glance_user:
  mysql_user.present:
    - host: {{ controller_host }}
    - password: {{ user password }}
    - connection_user: root
    - connection_pass: {{ database_pass }}
    - connection_charset: utf8
    - require:
      - pkg: python-mysql

glancedb_access1:
  mysql_grants.present:
    - grant: all privleges
    - database: glance.*
    - user: glance
    - require:
      - mysql_database: glance_database
      - mysql_user: glance_user

glancedb_access2:
  mysql_grants.present:
    - grant: all privleges
    - database: glance.localhost
    - user: glance
    - require:
      - mysql_database: glance_database
      - mysql_user: glance_user

/root/glance.sh:
  file.managed:
    - source: salt://glance/files/glance.sh
    - user: root
    - group: root
    - tempalte: jinja
    - mode: 750
    - require:
      - pkg: glance-pkgs

glance-services:
  service.running:
    - names:
      - glance-api
      - glance-registry
    - enable: True
    - require:
      - pkg: glance-pkgs
    - watch:
      - file: /etc/glance/glance-api.conf
      - file: /etc/glance/glance-registry.conf
      - cmd: glance_db_sync

glance_db_sync:
  cmd.wait:
    - name: 'glance-manage db_sync'
    - stateful: True
    - require:
      - mysql_database: glance_database
      - mysql_user: glance_user
      - mysql_grants: glancedb_access1
      - mysql_grants: glancedb_access2






