# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "nomad/map.jinja" import nomad with context %}

nomad-bin-dir:
  file.directory:
   - name: {{ nomad.bin_dir }}
   - makedirs: True

nomad-config-dir:
  file.directory:
    - name: {{ nomad.config_dir }}
    - makedirs: True

nomad-data-dir:
  file.directory:
    - name: {{ nomad.config.data_dir }}
    - makedirs: True

nomad-prepare-build:
  file.directory:
    - name: /tmp/nomad-v{{ nomad.version }}/go/src/github.com/hashicorp
    - user: nobody
    - makedirs: True
    - unless:
      - '{{ nomad.bin_dir }}/nomad -v && {{ nomad.bin_dir }}/nomad -v | grep {{ nomad.version }}'

nomad-check-build-packages:
  pkg.installed:
    - names:
      - {{ nomad.git_pkg }}
      - {{ nomad.make_pkg }}
    - onlyif:
      - 'command -v go'
    - onchanges:
      - nomad-prepare-build

nomad-checkout-repository:
  git.latest:
    - name: https://github.com/hashicorp/nomad.git
    - target: /tmp/nomad-v{{ nomad.version }}/go/src/github.com/hashicorp/nomad
    - rev: v{{ nomad.version }}
    - user: nobody
    - require:
      - nomad-check-build-packages
    - onchanges:
      - nomad-prepare-build
    - unless:
      - 'test -d /tmp/nomad-v{{ nomad.version }}/go/src/github.com/hashicorp/nomad'

nomad-build:
  cmd.run:
    - names: 
      - 'make bootstrap'
      - 'make dev'
    - cwd: '/tmp/nomad-v{{ nomad.version }}/go/src/github.com/hashicorp/nomad'
    - runas: nobody
    - env:
      - GOPATH: /tmp/nomad-v{{ nomad.version }}/go
      - PATH: '/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin:/usr/local/sbin:/tmp/nomad-v{{ nomad.version }}/go/bin'
    - require:
      - nomad-checkout-repository
    - onchanges:
      - nomad-prepare-build

nomad-install-binary:
  file.copy:
    - name: {{ nomad.bin_dir }}/nomad
    - source: /tmp/nomad-v{{ nomad.version }}/go/bin/nomad
    - force: True
    - require:
      - nomad-bin-dir
    - onchanges:
      - nomad-build

nomad-install-service:
   file.copy:
    - name: /etc/systemd/system/nomad.service
    - source: /tmp/nomad-v{{ nomad.version }}/go/src/github.com/hashicorp/nomad/dist/systemd/nomad.service
    - onchanges:
      - nomad-build
   cmd.wait:
    - name: 'systemctl daemon-reload'
    - require:
      - file: nomad-install-service
    - onchanges:
      - nomad-build

nomad-cleanup-build:
  file.absent:
    - name: '/tmp/nomad-v{{ nomad.version }}'
    - require:
      - nomad-install-binary
      - nomad-install-service
    - onchanges:
      - nomad-build
