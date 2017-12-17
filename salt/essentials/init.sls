basic_apps:
  pkg.installed:
    - pkgs:
      - wget
      - net-tools

synchronize-files:
  rsync.synchronized:
    - source: /files
