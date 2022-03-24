# Define Core-DNS Custom setting in AKS:

ref: https://docs.microsoft.com/zh-tw/azure/aks/coredns-custom
create this file corednsms.yaml:

aks dns server for each server real ip address.

```yaml
apiVersion: v1
data:
  test.server: |
    a.github.mycompany.com:53 {
        errors
        cache 30
        forward . 10.45.32.1
    }
    b.github.mycompany.com:53 {
        errors
        cache 30
        forward . 10.45.160.1
    }
kind: ConfigMap
metadata:
  labels:
    addonmanager.kubernetes.io/mode: EnsureExists
    k8s-app: kube-dns
    kubernetes.io/cluster-service: "true"
  name: coredns-custom
  namespace: kube-system
```

And then apply this config map , and delete all coredns pod, let it reload new config when it start. 

```bash
kubectl apply -f corednsms.yaml
kubectl delete pod --namespace kube-system --selector k8s-app=kube-dns
```
