{% from "nomad/map.jinja" import nomad with context %}
{{ nomad.config | json}}
