include:
  - rabbitmq.erlang

rabbitmq-pkgs:
  pkg.installed:
    - name: rabbitmq-server
    - version: 3.3.5-34.el7
    - require:
      - pkg: erlang-pkgs

rabbitmq-service:
  service.running:
    - name: rabbitmq-server
    - enable: True
    - require:
      - pkg: rabbitmq-pkgs

