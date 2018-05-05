include:
  - common.rabbitmq

rabbit_service:
  service.running:
    - name: rabbitmq-server
    - enable: True
    - require: rabbitmq-pkgs

rabbit_user:
  rabbitmq_user.present:
    - name: {{ salt['pillar.get']('rabbitmq:user') }}
    - password: {{ salt['pillar.get']('rabbitmq:password') }}
    - force: True
    - require:
      - service: rabbit_service

  rabbitmq_vhost.present:
    - name: "/"
    - user: {{ salt['pillar.get']('rabbitmq:user') }}
    - conf: .*
    - write: .*
    - read: .*
    - require:
      - rabbitmq_user: {{ salt['pillar.get']('rabbitmq:user') }}