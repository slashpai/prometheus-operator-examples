#!/usr/bin/env bash

kubectl apply -f namespace.yaml
kubectl apply -f secret-tls-certs.yaml
kubectl apply -f role-prometheus-k8s.yaml
kubectl apply -f rolebinding-prometheus-k8s.yaml
kubectl apply -f deployment-basic-auth-app.yaml
kubectl apply -f service.yaml
kubectl apply -f service-monitor.yaml