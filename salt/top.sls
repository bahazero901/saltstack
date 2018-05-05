base:
  "*":
    - essentials
    - docker
    - ssh
  "centos2"
    - ceph.admin
  "centos3"
    - ceph.monitor
  "centos1*":
#    - httpd
    - mysql
#  "*2"
#    - mysql
#   - mysql.master
#  "*3"
#    - mysql
#     - mysql.slave
# 'web* and G@wserv:nginx':
#    - match: compound    #need to specify the kind of matching
