{% import 'macros.yml' as macros %}

{{ macros.begin_stage('Deploy Ceph OSDs') }}

{% set dg_list = pillar['ceph-salt'].get('storage', {'drive_groups': []}).get('drive_groups', []) %}
{% for dg_spec in dg_list %}

{{ macros.begin_step('Deploy OSD group ' + (loop.index | string) + '/' + (dg_list | length | string)) }}

deploy ceph osds ({{ loop.index }}/{{ dg_list | length }}):
  cmd.run:
    - name: |
        ceph orch device ls --refresh
        echo '{{ dg_spec }}' | ceph orch apply osd -i -
    - failhard: True

{{ macros.end_step('Deploy OSD group ' + (loop.index | string) + '/' + (dg_list | length | string)) }}

{% endfor %}

{{ macros.end_stage('Deploy Ceph OSDs') }}
