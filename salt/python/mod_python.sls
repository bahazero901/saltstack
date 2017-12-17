include:
  - apache

extend: #extend makes apache watch this package
  apache:
    service:
      - watch:
        - pkg: mod_python

mod_python:
  pkg.installed
