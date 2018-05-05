include:
  - sensu

/sensu:
  rabbitmq_vhost.present:
    - require:
      - pkg: rabbitmq-pkgs

#running everytime I run a high state
sensu_rabbit_user:
  rabbitmq_user.present:
    - name: sensu
    - password: sensu
    - force: True
    - tags:
      - monitoring
      - sensu
    - perms:
      - '/sensu':
        - '.*'
        - '.*'
        - '.*'
    - require:
      - service: rabbitmq-service

sensu_restart:
  module.wait:
   - name: service.restart
   - m_name: sensu-pkgs
   - onchanges:
     - sensu_rabbit_user
