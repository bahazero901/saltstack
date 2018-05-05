{% set apache = salt['grains.filter_by']({
   'Debian': {
        'package': 'apache2',
        'service': 'apache2',
        'configfile': '/etc/apache2/apache2.conf',
        'configsource': 'salt://apache/files/debian-apache2.conf',
        'user': 'www-data',
        'group': 'www-data',
    },
    'RedHat': {
        'package': 'httpd',
        'service': 'httpd',
        'configfile': '/etc/httpd/conf/httpd.conf',
        'configsource': 'salt://apache/files/redhat-httpd.conf',
        'user': 'apache',
        'group': 'apache',
    },
})%}

