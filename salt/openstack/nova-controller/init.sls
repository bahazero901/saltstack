include:
  - common.openstack-pike
  - openstack.mysql
  - common.htpd

nova-controller-pkgs:
  pkg.installed:
    - pkgs:
      - openstack-nova-api
      - openstack-nova-conductor
      - openstack-nova-console
      - openstack-nova-novncproxy
      - openstack-nova-scheduler
      - openstack-nova-placement-api
    - require:
      - pkg: pike

nova-services:
  service.running:
    - names:
      - openstack-nova-api
      - openstack-nova-conductor
      - openstack-nova-console
      - openstack-nova-novncproxy
      - openstack-nova-scheduler
      - openstack-nova-placement-api
    - enable: True
    - require:
      - pkg: nova-controller-pkgs
    - watch:
      - file: /etc/nova/nova.conf
      - file: /etc/nova/api-paste.ini
      - cmd: nova_db_sync

nova-controller-nova.conf:
  file.managed:
    - name: /etc/nova/nova.conf
    - source: salt://nova-controller/files/nova.conf
    - user: nova
    - group: nova
    - mode: 640
    - templaate: jinja
    - require:
      - pkg: nova-controller-pkgs

/etc/httpd/conf.d/00-nova-placement-api.conf:
  file.managed:
    - source: salt://files/00-nova-placement-api.conf
    - user: nova
    - group: nova
    - mode: 640
    - templaate: jinja
    - require:
      - pkg: nova-controller-pkgs

nova_database:
  mysql_database:
    - name: nova
    - require:
      - pkg: python-mysql

nova_user:
  mysql_user.present:
    - host: {{ controller_host }}
    - password: {{ user password }}
    - connection_user: root
    - connection_pass: {{ root_database_pass }}
    - connection_charset: utf8
    - require:
      - pkg: python-mysql

novadb_access:
  mysql_grants.present:
    - grant: all privleges
    - database: nova.*
    - user: nova
    - require:
      - mysql_database: nova_database
      - mysql_user: nova_user

http_service:
  service.running:
    - name: httpd
    - watch:
      - file: /etc/httpd/conf.d/00-nova-placement-api.conf

populate_nova_db:
  cmd.wait:
    - name: nova-manage api_db sync