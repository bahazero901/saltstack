#https://www.tecmint.com/mariadb-master-slave-replication-on-centos-rhel-debian/

- include:
  - mysql

create_slave_user:
  mysql_user.present:
    - name: slave
    - host: localhost
    - password: password
    - connection_user: root
    - connection_pass: password
    - connection_charset: utf8
    - require:
      - pkg: python-mysql
