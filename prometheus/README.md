### How to rename label within a metric in Prometheus
source:
  - https://copyprogramming.com/howto/how-to-rename-label-within-a-metric-in-prometheus
  - https://prometheus.io/docs/prometheus/latest/querying/functions/#label_replace
```promSQL
label_replace(
 metrics_name{} , "rename_to_label_name", "$1", "origin_label_name", "(.+)"
)
label_replace(
node_systemd_unit_state{instance="server-01",job="node-exporters",name="kubelet.service",state="active"},
"unit_name","$1","name", "(.+)"
)

### example ###
### name rename to unit_name ###

sum(label_replace(
    node_systemd_unit_state{instance="server-01",job="node-exporters",name="kubelet.service",state="active"},
    "unit_name","$1","name", "(.+)"
    )
)by(unit_name)

```
