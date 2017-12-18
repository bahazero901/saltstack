docker-client:
  pkg.installed:
{% if grains['os_family'] == 'RedHat' %}
    - name: docker
{% endif %}
{% if grains['os_family'] == 'Debian' %}
    - name: docker.io
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
 
