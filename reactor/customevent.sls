clean_tmp:
  local.cmd.run:
    - tgt: 'os:Centos'
    - expr_form: grain
    - arg:
      - rm -rf /tmp/*
