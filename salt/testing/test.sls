/tmp/test.txt:
  file.managed:
    - source: salt://testing/test.txt
    - user: vagrant
    - group: vagrant
    - template: jinja
