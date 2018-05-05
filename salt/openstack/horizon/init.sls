- include:
  - common.openstack-pike-repo
  - common.memeached
  - common.httpd

horizon:
  pkg.installed:
    - name: openstack-dashboard
    - require:
      - pkg: pike

httpd:
  service.running:
    - watch:
      - file: /etc/openstack-dashboard/local_settings
    - require:
      - pkg: apache-pkgs

memcached:
  service.running:
    - watch:
      - file: /etc/openstack-dashboard/local_settings
    - require:
      - pkg: memcached-pkgs

/etc/openstack-dashboard/local_settings:
  file.managed:
    - source: salt://horizon/files/local_settings
    - owner: root
    - group: apache
    - template: jinja
    - mode: 640
