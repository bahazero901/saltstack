### common.sls ###
  
  {% if grains['os'] == 'Debian' %}
  apache: apache2
  {% elif grains['os'] == 'RedHat' %}
  apache: httpd
  {% endif %}
  
  users:
    jaber:
      username: gjaber
      password: <cryptographic hash or a extract of a perl script here>
      moba: LoL
    rondon:
      username: mrondon
      password: <cryptographic hash or a extract of a perl script here>
      moba: Dota2
  
  dns:
    server1: 8.8.8.8
    server2: 8.8.4.4
