include:
  - docker 

setenforce0:
  selinux.mode:
    - name: permissive

net.bridge.bridge-nf-call-ip6tables:
  sysctl.present:
    - value: 1

net.bridge.bridge-nf-call-iptables:
  sysctl.present:
    - value: 1

kubernetes-repo:
  pkgrepo.managed:
    - name: Kubernetes
    - humanname: Kubernetes Yum Repo
    - enabled: True
    - baseurl: https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
    - gpgcheck: 1
    - gpgkey: https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg

kubernetes-pkgs:
  pkg.installed:
    - pkgs:
      - kubelet: 1.10.2-0
      - kubeadm: 1.10.2-0
      - kubectl: 1.10.2-0
    - require:
      - pkgrepo: kubernetes-repo
      - pkg: docker

start_kubelet:
  service.running:
    - name: kubelet
    - enable: True
    - require:
      - pkg: kubernetes-pkgs


