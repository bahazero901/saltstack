- require:
  - openstack-pike
  - glance
  - openstack-rabbitmq

openstack-nova-compute-pkgs:
  pkg.installed:
    - name: openstack-nova-compute
    - require:
      - pkg: pike

nova_compute_service:
  service.running:
    - names:
      - libvirtd
      - openstack-nova-compute
    - require:
      - pkg: openstack-nova-compute-pkgs
    - watch:
      - file: nova-compute-nova.conf

nova-compute-nova.conf:
  file.managed:
    - name: /etc/nova/nova.conf
    - source: salt://nova-compute/files/nova.conf
    - owner: nova
    - group: nova
    - template: jinja
    - required:
      - pkg: openstack-nova-compute-pkgs