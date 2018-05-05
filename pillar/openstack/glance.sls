cinder:
  db:
    password: password
  service:
    api_paste_confg: /etc/cinder/api-paste.ini
    auth_strategy: keystone
    debug: False
    iscsi_helper: tgtadm
    lock_path: /var/lock/cinder
    state_path: /var/lib/cinder
    verbose: False
    volume_api_class: nova.volume.cinder.API
    volume_driver: cinder.volume.driver.ISCSIDriver
    volume_group: cinder-volumes
    volume_name_template: volume-%s
    volumes_dir: /var/lib/cinder/volumes
    password: ca$hc0w
    rootwrap_config: /etc/cinder/rootwrap.conf