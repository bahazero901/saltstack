base:
  "mysql*":
    - mysql
  "*":
    - essentials
    - docker
  "centos*":
    - nginx
# 'web* and G@wserv:nginx':
#    - match: compound    #need to specify the kind of matching
