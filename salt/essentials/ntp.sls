#determine if I want to use ntp or chrony
ntp-pkgs:
  pkg.installed:
    - name: ntp
#  service.running:
#    - name: ntpd



