include:
  - epel

erlang-pkgs:
  pkg.installed:
    - name: erlang
    - version: R16B-03.18.el7
    - require: 
      - pkg: epel-pkgs
