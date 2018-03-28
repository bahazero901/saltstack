mysql-pkg:
  pkg.installed:
    - name: mysql-community-server
  require:
    - pkgrepo.managed: mysql_repository

mysql-start-service:
  service.running:
    - name: mysqld
    - enable: True
  require:
    - pkg: mysql-pkg

mysql_repository:
  pkgrepo.managed:
    - humanname: MySQL 5.6
    - baseurl: http://repo.mysql.com/yum/mysql-5.6-community/el/7/$basearch/
    - enabled: True
    - gpgcheck: False
  
