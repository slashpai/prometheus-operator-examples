# prometheus-operator-examples

prometheus-operator example configs

**Disclaimer:** *The configs in this repo should be treated as examples only. This is not tested in production cluster. These examples can serve as a starting point for creating production ready configs.*

For each example config, check README page in respective folder.

## Pre-requisites

Create kind cluster or minikube cluster (examples in this repo are tested with minikube)

```bash
$ minikube delete && minikube start --kubernetes-version=v1.26.5 --memory=6g --bootstrapper=kubeadm --extra-config=kubelet.authentication-token-webhook=true --extra-config=kubelet.authorization-mode=Webhook --extra-config=scheduler.bind-address=0.0.0.0 --extra-config=controller-manager.bind-address=0.0.0.0
```

[kube-prometheus](https://github.com/prometheus-operator/kube-prometheus#quickstart) stack is configured in cluster before running any examples. Quick start creates a namespace `monitoring` and deploys monitoring components in that. This will help us setup monitoring stack out of the box. 

```bash
git clone git@github.com:prometheus-operator/kube-prometheus.git;
cd kube-prometheus;
kubectl apply --server-side -f manifests/setup
kubectl wait \
	--for condition=Established \
	--all CustomResourceDefinition \
	--namespace=monitoring
kubectl apply -f manifests/
```

You should following pods after quick start commands are applied (This will take a while for all pods to come up)

```bash
░▒▓    ~/gi/s/kube-prometheus  on   main ?1  kubectl get pods -n monitoring                                             ✔  3.9.5   1.20.2   2.7.3   at minikube ⎈  at 21:55:02  ▓▒░
NAME                                   READY   STATUS    RESTARTS   AGE
alertmanager-main-0                    2/2     Running   0          2m39s
alertmanager-main-1                    2/2     Running   0          2m39s
alertmanager-main-2                    1/2     Running   0          2m39s
blackbox-exporter-6bc47b9578-lc5f8     3/3     Running   0          5m8s
grafana-57f885b6c8-jdglq               1/1     Running   0          5m7s
kube-state-metrics-f76ffbf8b-kfp9j     3/3     Running   0          5m7s
node-exporter-46c4s                    2/2     Running   0          5m6s
prometheus-adapter-6b88dfd544-jv2rd    1/1     Running   0          5m6s
prometheus-adapter-6b88dfd544-p8bzk    1/1     Running   0          5m6s
prometheus-k8s-0                       2/2     Running   0          2m39s
prometheus-k8s-1                       2/2     Running   0          2m39s
prometheus-operator-58899ccbf4-9pv7p   2/2     Running   0          5m6s
```

## Helpful Commands

- Access Prometheus UI

  ```bash
  kubectl -n monitoring port-forward svc/prometheus-k8s 9090
  ```

- Access AlertManager UI

  ```bash
  kubectl -n monitoring port-forward svc/alertmanager-main 9093
  ```
