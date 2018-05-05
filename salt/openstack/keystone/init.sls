include:
  - common.openstack-pike-repo
  - openstack.python-mysqldb
  - openstack.httpd
  - openstack.mysql

keystone-pkgs:
  pkg.installed:
    - name:
      - openstack-keystone
    - require:
      - pkgrepo: pike

keystone-service:
  service.running:
    - name: openstack-keystone
    - enable: True
    - require:
      - pkg: keystone-pkgs
    - watch:
      - file: /etc/keystone/keystone.conf

/etc/keystone/keystone.conf:
  file.managed:
    - source: salt://keystone/files/keystone.conf
    - user: keystone
    - group: keystone
    - mode: 640
    - template: jinja
    - require:
      - pkg: keystone-pkgs

/etc/httpd/conf/httpd.conf:
  - file.append:
    - text:
      - "ServerName controller"
    - require:
      - pkg: mod_wsgi

http-symlink:
  file.symlink:
    - name: /usr/share/keystone/wsgi-keystone.conf
    - target: /etc/httpd/conf.d/
    - user: root
    - group: root
    - mode: 640
    - require:
      - pkg: apache-pks

#create database and grant access
create_keystone_db:
  mysql_database.present:
    - name: keystone
    - require:
      - pkg: python-mysql #need to check this

keystone_user:
  mysql_user.present:
    - host: localhost
    - password: "bob@cat"
    - connection_user: someuser
    - connection_pass: somepass
    - requires:
      - mysql_database: create_keystone_db

keystone_permissions1:
  mysql_grants.present:
    - grant: all privileges
    - database: keystone.*
    - user: keystone
    - requires:
      - mysql_user: keystone_user

keystone_permissions2:
  mysql_grants.present:
    - grant: all privileges
    - database: keystone.localhost
    - user: keystone
    - requires:
      - mysql_user: keystone_user

populate_keystone_db:
  cmd.wait:
    - name: keystone-manage db_sync
    - require:
      - mysql_grants: keystone_permissions1
      - mysql_grants: keystone_permissions2

fernet_setup:
  cmd.wait:
    - name: keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
    - require:
      - cmd: populate_keystone_db

credential_setup:
  cmd.wait:
    - name: keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
    - require:
      - cmd: fernet_setup

bootstrap_keystone:
  cmd.wait:
    - name: keystone-manage bootstrap --bootstrap-password {{ get pillar password }} \
  --bootstrap-admin-url http://controller:35357/v3/ \
  --bootstrap-internal-url http://controller:5000/v3/ \
  --bootstrap-public-url http://controller:5000/v3/ \
  --bootstrap-region-id RegionOne
    - require:
      - cmd: fernet_setup
      - cmd: credential_setup

/root/keystone.sh:
  file.managed:
    - source: salt://keystone/files/
    - user: root
    - group: root
    - mode: 750
    - require:
      - mysql_database: keystone_database
      - mysql_user: keystone_user
      - mysql_grants: keystone_permissions1
      - mysql_grants: keystone_permissions2
