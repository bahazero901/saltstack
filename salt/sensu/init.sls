include:
  - rabbitmq
  - redis

sensu-repository:
  pkgrepo.managed:
   - name: [sensu]
   - humanname: sensu-main
   - baseurl: http://repositories.sensuapp.org/yum/el/7/x86_64/
   - enabled: True
   - gpgcheck: 0

sensu-pkgs:
  pkg.installed:
    - name: sensu
    - version: 1:0.26.5-2
    - require:
      - pkgrepo: sensu-repository
      - pkg: rabbitmq-pkgs
      - pkg: redis-pkgs

sensu-server-services:
  service.running:
    - name: sensu-server
    - enable: True
    - require:
      - pkg: sensu-pkgs

sensu-client-services:
  service.running:
    - name: sensu-client
    - enable: True
    - require:
      - pkg: sensu-pkgs
