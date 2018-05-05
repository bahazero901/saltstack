- include:
  - mysql

create_database:
  mysql_database:
    - name: testdatabase
    - require:
      - pkg: mysql-pkgs
      - pkg: python-mysql

create_slave_user:
  mysql_user.present:
    - name: slave_user
    - host: localhost
    - password: 
    - connection_user: root
    - connection_pass: password
    - connection_charset: utf8
    - require:
      - pkg: python-mysql
      - mysql_database
