- include:
  - common.openstack-pike
  - openstack-neutron
  - nova-compute

neutron-pkgs:
  pkg.installed:
    - pkgs:
      - openstack-neutron-linuxbridge
      - ebtables
      - ipset

neutron_service:
  service.running:
    - name: neutron-linuxbridge-agent
    - require:
      - pkg: neutron-pkgs
    - watch:
      - file: /etc/neutron/neutron.conf

/etc/neutron/neutron.conf:
  file.managed:
    - source: salt://neutron/files/neutron.conf
    - user: neutron
    - group: neutron
    - template: jinja
    - require:
      - pkg: neutron-pkgs


#will have to include nova and append neutron to data
#then watch nova services
#https://docs.openstack.org/neutron/pike/install/compute-install-rdo.html

append_neutron_nova.conf:
  file:
    - name: /etc/nova/nova.conf
    - append
    - template: jinja
    - source:
      - salt://neutron-controller/files/neutron_compute_nova.conf
    - require:
      - file: nova-compute-nova.conf