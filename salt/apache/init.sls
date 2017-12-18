{% if grains['os'] == 'RedHat'%}
{% set apache_pkg = 'httpd' %}
{% set apache_conf = '/etc/httpd/httpd.conf' %}
{% set apache_conf_source = 'salt://apache/httpd.conf' %}
{% elif grains['os'] == 'Debian' %}
{% set apache_pkg = 'apache2' %}
{% set apache_conf = '/etc/apache2/apache2.conf' %}
{% endif %}

apache:
  pkg.installed:
    - name: {{ apache_pkg }}

apache_running
  service.running:
    - name: {{ apache_pkg }}
    - enable: True
    - watch:
      - pkg: apache
      - file: {{ apache_conf }}
      - user: apache
  user.present:
    - name: apache
    - uid: 87
    - gid: 87
    - home: /var/www/html
    - shell: /bin/nologin
    - require:
      - group: apache
  group.present:
    - gid: 87
    - require:
      - pkg: apache

/etc/httpd/conf/httpd.conf:
  file.managed:
    - source: {{ aoache_conf_source }}
    - user: root
    - group: root
    - mode: 644
