# Addiitonal Scrape Configs

```bash
kubectl create secret generic additional-scrape-configs --from-file=prometheus-additional-configs.yaml --dry-run=client -oyaml > additional-scrape-configs.yaml
```

```bash
kubectl apply -f additional-scrape-configs.yaml
```

Add following section in Prometheus resource spec

```yaml
additionalScrapeConfigs:
    name: additional-scrape-configs
    key: prometheus-additional-configs.yaml
```

 - Refresh prometheus target page it should show pod monitor targets
![img](img/kubernetes_node_monitoring.png)
