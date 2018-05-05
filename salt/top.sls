base:
  "*":
    - essentials
    - docker
  "mysql*":
    - mysql
  "centos*":
    - httpd
# 'web* and G@wserv:nginx':
#    - match: compound    #need to specify the kind of matching
