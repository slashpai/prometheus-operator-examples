# Configure remote-write to thanos

## Pre-requisite

Have a kube-prometheus stack setup using [quick start](https://github.com/prometheus-operator/kube-prometheus#quickstart)

## Steps

1. Deploy thanos (You can use existing thanos setup if you have, update fields accordingly)

    ```bash
    git clone https://github.com/slashpai/deploy-thanos-kubernetes.git
    cd deploy-thanos-kubernetes
    kubectl apply -f manifests
    ```

2. Configure remote-write

  - Add remoteWrite config to [prometheus cr](https://github.com/prometheus-operator/kube-prometheus/blob/main/manifests/prometheus-prometheus.yaml)

  - Existing prometheus cr on kube-prometheus as of now. 

    ```yaml
    apiVersion: monitoring.coreos.com/v1
    kind: Prometheus
    metadata:
      labels:
        app.kubernetes.io/component: prometheus
        app.kubernetes.io/instance: k8s
        app.kubernetes.io/name: prometheus
        app.kubernetes.io/part-of: kube-prometheus
        app.kubernetes.io/version: 2.44.0
      name: k8s
      namespace: monitoring
    spec:
      alerting:
        alertmanagers:
        - apiVersion: v2
          name: alertmanager-main
          namespace: monitoring
          port: web
      enableFeatures: []
      externalLabels: {}
      image: quay.io/prometheus/prometheus:v2.44.0
      nodeSelector:
        kubernetes.io/os: linux
      podMetadata:
        labels:
          app.kubernetes.io/component: prometheus
          app.kubernetes.io/instance: k8s
          app.kubernetes.io/name: prometheus
          app.kubernetes.io/part-of: kube-prometheus
          app.kubernetes.io/version: 2.44.0
      podMonitorNamespaceSelector: {}
      podMonitorSelector: {}
      probeNamespaceSelector: {}
      probeSelector: {}
      replicas: 2
      resources:
        requests:
          memory: 400Mi
      ruleNamespaceSelector: {}
      ruleSelector: {}
      securityContext:
        fsGroup: 2000
        runAsNonRoot: true
        runAsUser: 1000
      serviceAccountName: prometheus-k8s
      serviceMonitorNamespaceSelector: {}
      serviceMonitorSelector: {}
      version: 2.44.0
      ```

  - Add entry for remoteWrite after `version` field. The url field points to thanos-receiver service which was deployed earlier. You can get the name of service by running `kubectl get svc -n monitoring`

    ```yaml
    remoteWrite:
      - url: http://thanos-receive-ingestor-default:19291/api/v1/receive
    ```

  -  After updating the prometheus cr it would look like [prometheus-prometheus.yaml](prometheus-prometheus.yaml). Apply the changes to kubernetes cluster

      ```bash
      kubectl apply -f prometheus-prometheus.yaml
      ```

3. Wait sometime till new config is rolled out. Once its updated you should be able to see remoteWrite settings in prometheus configuration

4. Check if metrics available in thanos using thanos querier

    ```bash
    kubectl -n monitoring port-forward svc/thanos-query 9091:9090&
    ```

    ![img](img/thanos_querier_1.png)

    ![img](img/thanos_querier_2.png)