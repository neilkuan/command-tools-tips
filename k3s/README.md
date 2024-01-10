## K3S demo config
- source: https://docs.k3s.io/installation/configuration
- orbstack ([1.2.0](https://orbstack.dev))


### Demo local machine use orbstack to create vm.
```bash
### orbstack creare machine name k3s.
orb create ubuntu k3s

### orbstack exec into machine k3s as root user.
orb run -m k3s --user root bash
```


#### Into k3s machine
```bash
### Download k3s binrary
curl -Lo /usr/local/bin/k3s https://github.com/k3s-io/k3s/releases/download/v1.26.5+k3s1/k3s; chmod a+x /usr/local/bin/k3s

### Create k3s default dir.
mkdir -p /etc/rancher/k3s/

### Create k3s default config.

vim /etc/rancher/k3s/config.yaml
```

```yaml
write-kubeconfig-mode: "0644"
tls-san:
  - "orb.local"
  - "127.0.0.1"
node-label:
  - "foo=bar"
  - "something=amazing"
cluster-init: true
```

### Create k3s cluster
```
curl -sfL https://get.k3s.io | sh -
```

### Default k3s kubeconfig
```bash
ls -l /etc/rancher/k3s/k3s.yaml


root@k3s:/etc/rancher/k3s# kubectl get pod -A
NAMESPACE     NAME                                      READY   STATUS      RESTARTS   AGE
kube-system   coredns-6799fbcd5-h2vbc                   1/1     Running     0          17m
kube-system   helm-install-traefik-crd-vlvvn            0/1     Completed   0          17m
kube-system   helm-install-traefik-lgs2s                0/1     Completed   1          17m
kube-system   local-path-provisioner-84db5d44d9-vfpk5   1/1     Running     0          17m
kube-system   metrics-server-67c658944b-sskvv           1/1     Running     0          17m
kube-system   svclb-traefik-0118512f-qb5qq              2/2     Running     0          15m
kube-system   traefik-f4564c4f4-hl9bx                   1/1     Running     0          15m


root@k3s:/etc/rancher/k3s# kubectl --kubeconfig /etc/rancher/k3s/k3s.yaml  get pod -A 
NAMESPACE     NAME                                      READY   STATUS      RESTARTS   AGE
kube-system   coredns-6799fbcd5-h2vbc                   1/1     Running     0          17m
kube-system   helm-install-traefik-crd-vlvvn            0/1     Completed   0          17m
kube-system   helm-install-traefik-lgs2s                0/1     Completed   1          17m
kube-system   local-path-provisioner-84db5d44d9-vfpk5   1/1     Running     0          17m
kube-system   metrics-server-67c658944b-sskvv           1/1     Running     0          17m
kube-system   svclb-traefik-0118512f-qb5qq              2/2     Running     0          16m
kube-system   traefik-f4564c4f4-hl9bx                   1/1     Running     0          16m
```



