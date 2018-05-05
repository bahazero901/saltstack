redis-pkgs:
  pkg.installed:
    - name: redis
    - version: 3.2.10-2.el7
  service.running:
    - name: redis
    - enable: True


