## Pre-requisite

kind/minikube cluster created as in README or update the commands accordingly

### Label nodes to filter later

```bash
kubectl label node multi-node-control-plane node.kubernetes.io/instance-type=master
kubectl label node multi-node-worker node.kubernetes.io/instance-type=worker
kubectl label node multi-node-worker2 node.kubernetes.io/instance-type=worker
```

### Create service account token for authrorization

```bash
kubectl apply -f sa-secret-prom.yaml
```

### Create secret for TLS config

```bash
kubectl apply -f tls-secret.yaml
```
