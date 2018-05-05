httpd-pkgs:
  pkg.installed:
    - name: httpd
    - version: 2.4*

httpd-service:
  service.running:
    - name: httpd
    - enable: True
    - require:
       - pkg: httpd-pkgs
    - watch:
       - file: /etc/httpd/conf/httpd.conf     

/etc/httpd/conf/httpd.conf:
  file.managed:
    - source: salt://httpd/files/httpd.conf
    - user: root
    - group: root
    - mode: 644

httpd_config_restart:
  module.wait:  
   - name: service.restart
   - m_name: httpd-pkgs
   - onchanges:
     - /etc/httpd/conf/httpd.conf

