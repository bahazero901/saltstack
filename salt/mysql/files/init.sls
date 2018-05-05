#https://www.tecmint.com/how-to-setup-mysql-master-slave-replication-in-rhel-centos-fedora/

mysql-pkgs:
  pkg.installed:
    - name: mysql-server
  require:
    - pkgrepo: mysql_repository

mysql-start-service:
  service.running:
    - name: mysqld
    - enable: True
  require:
    - pkg: mysql-pkgs

mysql_repository:
  pkgrepo.managed:
    - humanname: MySQL 5.6
    - baseurl: http://repo.mysql.com/yum/mysql-5.6-community/el/7/$basearch/
    - enabled: True
    - gpgcheck: False

mysql-python:
  pkg.installed:
    - name: MySQL-python
#    - require:
#      - pkg: mysql-pkgs

root_user:
  mysql_user.present:
    - name: root
    - password: password
    - host: localhost  
    - require: 
      - pkg: mysql-python
