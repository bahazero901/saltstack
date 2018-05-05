- include:
  - common.httpd

mod_wsgi:
  pkg.installed:
    - require:
      - pkg: httpd

httpd:
  service.running:
    - enable: True
    - watch:
      - file: /etc/httpd/conf.d/

httpd:
  service.running:
    - enable: True
    - require:
      - pkg: mod_wsgi
    - watch:
      - file: /etc/keystone/keystone.conf
      - file: /etc/httpd/conf.d/00-nova-placement-api.conf
