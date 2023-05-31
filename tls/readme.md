TLS Example
===========

This example shows how to setup TLS on Service Monitor, so that Prometheus can scrape targets secured by TLS. 

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

It will setup a namespace `example-monitoring-tls`, inside which, there is a service secured by TLS using private key and server certificate, as well as a service monitor using the same pair of key and certificate to access the service endpoint.

In the given example certificate is not validated. For a better approach we need to use cert-manager. More examples to follow on this.

Take a look at [cert-manager-documentation](https://cert-manager.io/docs/configuration/selfsigned/) for self signed certificates.

**TODO:** Explore the possibility with [mkcert](https://github.com/FiloSottile/mkcert) with cert-manager for local testing
