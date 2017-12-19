#will listen for changes on the sshd_config file
beacon:
  inotify:
    /etc/ssh/sshd_config:
      mask:
        - modified:
  disable_during_state_run: True
