include:
  - ceph

#will need to use pillar to allow installs in ubuntu and centos

ceph-pkgs:
  pkg.installed:
    - name: ceph-deploy
