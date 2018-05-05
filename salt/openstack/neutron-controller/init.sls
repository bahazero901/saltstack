- include:
  - common.openstack-pike
  - opensack-rabbitmq
  - nova-controller
  - mysql

neutron-pkgs:
  pkg.installed:
    - pkgs:
      - openstack-neutron
      - openstack-neutron-ml2
      - openstack-neutron-linuxbridge
      - ebtables
    - require:
      - pike

neutron_services:
  services.running:
    - names:
      - neutron-server
      - neutron-linuxbridge-agent
      - neutron-dhcp-agent
      - neutron-metadata-agent
      - neutron-l3-agent
    - enable: True
    - require:
      - pkg: neutron-pkgs
    - watch:
      - file: /etc/neutron/dhcp_agent.ini
      - file: /etc/neutron/l3_agent.ini
      - file: /etc/neutron/plugins/ml2/linuxbridge_agent.ini
      - file: /etc/neutron/plugins/ml2/ml2_conf.ini
      - file: /etc/neutron/neutron.conf

create_neutron_database:
  mysql_database:
    - name: neutron
    - require:
      - pkg: mysql
      - pkg: python-mysql

create_neutron_user:
  mysql_user.present:
    - name: neutron
    - host: {{ controller_host }}
    - password: {{ user password }}
    - connection_user: root
    - connection_pass: {{ root_database_pass }}
    - connection_charset: utf8
    - require:
      - pkg: python-mysql
      - mysql_database: create_neutron_database

neutrondb_access:
  mysql_grants.present:
    - grant: all privileges
    - database: neutron.*
    - user: neutron
    - require:
      - mysql_database: create_neutron_database
      - mysql_user: create_neutron_user

/etc/neutron/neutron.conf:
  file.managed:
    - source: salt://neutron-controller/files/neutron.conf
    - user: neutron
    - group: neutron
    - template: jinja
    - mode: 640
    - require:
      - pkg: neutron-pkgs

/etc/neutron/plugins/ml2/ml2_conf.ini:
  file.managed:
    - source: salt://neutron-controller/files/ml2_conf.ini
    - user: neutron
    - group: neutron
    - template: jinja
    - mode: 640
    - require:
      - pkg: neutron-pkgs

/etc/neutron/plugins/ml2/linuxbridge_agent.ini:
  file.managed:
    - source: salt://neutron-controller/files/linuxbridge_agent.ini
    - user: neutron
    - group: neutron
    - template: jinja
    - mode: 640
    - require:
      - pkg: neutron-pkgs

/etc/neutron/l3_agent.ini:
  file.managed:
    - source: salt://neutron-controller/files/l3_agent.ini
    - user: neutron
    - group: neutron
    - template: jinja
    - mode: 640
    - require:
      - pkg: neutron-pkgs

/etc/neutron/dhcp_agent.ini:
  file.managed:
    - source: salt://neutron-controller/files/dhcp_agent.ini
    - user: neutron
    - group: neutron
    - template: jinja
    - mode: 640
    - require:
      - pkg: neutron-pkgs

/etc/neutron/plugins/ml2/ml2_conf.ini /etc/neutron/plugin.ini:
  file.symlink:
    - name: /etc/neutron/plugins/ml2/ml2_conf.ini
    - target: /etc/neutron/plugin.ini
    - user: neutron
    - group: neutron
    - mode: 640
    - require: neutron-pkgs

append_neutron_nova.conf:
  file:
    - name: /etc/nova/nova.conf
    - append
    - template: jinja
    - source:
      - salt://neutron-controller/files/nova-controller-nova.conf
    - require:
      - file: nova-controller-nova.conf

db_neutron_sync:
  cmd.wait:
    - name: 'neutron-db-manage --config-file /etc/neutron/neutron.conf \
  --config-file /etc/neutron/plugins/ml2/ml2_conf.ini upgrade head'
    - require:
      - mysql_grants: neutrondb_access
      - source:

