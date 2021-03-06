{% if grains['os_family'] == "RedHat" %}
nginx-repository:
  pkgrepo.managed:
    - name: Nginx-Repo
    - humanname: nginx.repo 
    - baseurl: http://nginx.org/packages/mainline/rhel/7/$basearch/ 
    - gpgcheck: True
    - gpgkey: https://nginx.org/keys/nginx_signing.key
    - enabled: True
{% endif %}

nginx-pkg:
  pkg.installed:
    - name: nginx
#    - version: 1:1.13.12-1.el7
{% if grains['os_family'] == "RedHat" %}
  require:
    - pkgrepo.managed: nginx-repository
{% endif %}
