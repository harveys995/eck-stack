#!/bin/bash

echo "Installing Elastic Cloud on Kubernetes (ECK)..."
kubectl apply -f https://download.elastic.co/downloads/eck/3.0.0/crds.yaml
kubectl apply -f https://download.elastic.co/downloads/eck/3.0.0/operator.yaml

echo "Installing Stackable Operator"
stackablectl operator install \
  commons=25.3.0 \
  secret=25.3.0 \
  listener=25.3.0 \
  zookeeper=25.3.0 \
  kafka=25.3.0


echo "Creating data-layer"
kubectl create ns data-layer

echo "Deploying eck-stack..."
cd /Users/harveysandhu/GitHub_Projects/eck-stack/elastic-cluster
helmfile -e dev apply

echo "Modifying context to eck-stack..."
kubectl config set-context --current --namespace=eck-stack

