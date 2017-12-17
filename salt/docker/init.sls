docker-client:
  pkg.install:
{% if grains['os'] == 'RedHat' %}
    - name: docker
{% endif %}
{% if grains['os'] == 'Debian' %}
    - name: docker.io
{% endif %}
  
