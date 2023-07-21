#!/usr/bin/bash

if kubectl get namespace -o jsonpath='{.items[*].metadata.name}' | grep -q dev
then
  echo "==================================================================="
  echo "namespace: dev"
  echo
  kubectl get pods -o custom-columns="POD NAME:.metadata.name,IP ADDRESS:.status.podIP" -n dev
  echo
  kubectl get svc -o custom-columns="SERVICE NAME:.metadata.name,CLUSTER-IP:.spec.clusterIP" -n dev
  echo
  echo "==================================================================="
fi

if kubectl get namespace -o jsonpath='{.items[*].metadata.name}' | grep -q prod
then
  echo "namespace: prod"
  echo
  kubectl get pods -o custom-columns="POD NAME:.metadata.name" -n prod
  echo
  echo "==================================================================="
fi