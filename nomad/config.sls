# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "nomad/map.jinja" import nomad with context %}

nomad-config:
  file.managed:
    - name: {{ nomad.config_dir }}/nomad.hcl
    - source: salt://nomad/files/nomad.hcl
    - mode: 644
    - user: root
    - group: root
    - template: jinja
    {% if nomad.service != False %}
    - watch_in:
       - service: nomad
    {% endif %}

# Enabling the service here to ensure each state is independent.
nomad-service:
  service.running:
    - name: nomad
    - enable: {{ nomad.service }}
