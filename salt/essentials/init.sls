basic-essentials:
  pkg.installed:
    - pkgs:
      - wget
      - net-tools
      - tree
      - vim-enhanced
      - ipmitool: 1.8.18-5.el7
      - mcelog: 3:144-3.94d853b2ea81.el7

permissive-selinux:
  selinux.mode:
    - name: permissive
