openssh-pkgs:
  pkg.installed:
   - name: openssh-server

sshd:
  service.running:
    - enable: True
    - require:
      - pkg: openssh-pkgs

/etc/ssh/sshd_config:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://ssh/files/sshd_config
    - require:
      - pkg: openssh-server

/etc/ssh/banner:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://ssh/files/banner
    - require:
      - pkg: openssh-server

sshd_config_restart:
  module.wait:
   - name: service.restart
   - m_name: openssh-pkgs
   - onchanges:
     - /etc/ssh/sshd_config
     - /etc/ssh/banner
