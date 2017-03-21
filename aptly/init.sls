aptly:
  pkg.installed:
    - name: aptly
    - refresh: True

# dependency for publishing
bzip2:
  pkg.installed

aptly_group:
  group.present:
    - name: aptly
    {% if salt['pillar.get']('aptly:user:gid', 0) %}
    - gid: {{ salt['pillar.get']('aptly:user:gid') }}
    {% else %}
    - system: true
    {% endif %}

aptly_user:
  user.present:
    - name: aptly
    - system: true
    - shell: /bin/bash
    - home: {{ salt['pillar.get']('aptly:homedir', '/var/lib/aptly') }}
    - require:
      - pkg: aptly
    {% if salt['pillar.get']('aptly:user:uid', 0) %}
    - uid: {{ salt['pillar.get']('aptly:user:uid') }}
    {% else %}
    - gid_from_name: True
    {% endif %}
