include:
  - senu

uchiwa-pkgs:
  pkg.installed:
    - name: uchiwa

uchiwa-services:
  service.running:
    - name: uchiwa
    - enable: True
