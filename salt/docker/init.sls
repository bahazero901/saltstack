docker-client:
  pkg.installed:
{% if grains['os_family'] == 'RedHat' %}
    - name: docker
    - version: 1.12.6
{% endif %}
{% if grains['os_family'] == 'Debian' %}
    - name: docker.io
    - version: 1.12.6
{% endif %}

docker-start-service:
  service.running:
    - name: docker
    - enable: True
  require:
    - pkg: docker-client

docker-group-create:
  group.present:
    -  name: docker
    -  addusers:
{% if grains['os_family'] == 'RedHat' %}
         - vagrant
{% elif grains['os_family'] == 'Debian' %}
         - ubuntu
{% endif %}
 
