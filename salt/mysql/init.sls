mysql-pkgs:
  pkg.installed:
    - name: mariadb-server

mysql-start-service:
  service.running:
    - name: mariadb
    - enable: True
  require:
    - pkg: mysql-pkgs

mysql-python:
  pkg.installed:
    - name: MySQL-python
    - require:
      - pkg: mysql-pkgs

create_root_user:
  mysql_user.present:
    - name: root
    - password: password
    - host: localhost
    - require:
      - pkg: mysql-python
