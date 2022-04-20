# prometheus-operator-examples

prometheus-operator example configs

## Pre-requisites

Create kind cluster or minikube cluster (examples in this repo are tested with minikube)

```bash
$ minikube delete && minikube start --kubernetes-version=v1.23.0 --memory=6g --bootstrapper=kubeadm --extra-config=kubelet.authentication-token-webhook=true --extra-config=kubelet.authorization-mode=Webhook --extra-config=scheduler.bind-address=0.0.0.0 --extra-config=controller-manager.bind-address=0.0.0.0
```

[kube-prometheus](https://github.com/prometheus-operator/kube-prometheus#quickstart) stack is configured in cluster before running any examples

**Note:** The configs in this repo should be treated as examples only. This is not tested in production cluster. These examples can serve as a starting point for creating production ready configs

## Helpful Commands

- Access Prometheus UI

```bash
kubectl -n monitoring port-forward svc/prometheus-k8s 9090
```
