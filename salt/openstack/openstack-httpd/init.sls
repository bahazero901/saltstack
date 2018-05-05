- include:
  - httpd

mod_wsgi:
  pkg.installed:
    - require:
      - pkg: httpd-pkgs

httpd:
  service.running:
    - enable: True
    - require:
      - pkg: mod_wsgi
    - watch:
      - file: /etc/keystone/keystone.conf
      - file: /etc/httpd/conf.d/00-nova-placement-api.conf
