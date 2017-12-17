include:
  - ssh.server  #includes ssh/server.sls

extend:
  /etc/ssh/banner:
    file:
      - source: salt://ssh/custom-banner
