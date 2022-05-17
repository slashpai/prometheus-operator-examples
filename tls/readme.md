TLS Example
===========

This example shows how to setup TLS on Service Monitor, so that Prometheus can scrape targets secured by TLS. 

To run the example, please make sure to install the bundle from [Kube-Prometheus](https://github.com/raptorsun/kube-prometheus).

Then we apply the manifests in this directory. This snippet is in `run.sh`.
```bash 
kubectl apply -f namespace.yaml
kubectl apply -f secret-tls-certs.yaml
kubectl apply -f role-prometheus-k8s.yaml
kubectl apply -f rolebinding-prometheus-k8s.yaml
kubectl apply -f deployment-basic-auth-app.yaml
kubectl apply -f service.yaml
kubectl apply -f service-monitor.yaml
```

It will setup a namespace `example-monitoring`, inside which, there is a service secured by TLS using private key and server certificate, as well as a service monitor using the same pair of key and certificate to access the service endpoint. 

