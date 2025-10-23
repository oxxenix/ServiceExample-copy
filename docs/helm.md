# Manual Helm Chart Installation

This guide describes how to manually install the ServiceExample Helm chart.
Useful for local testing, troubleshooting, or temporary environments.

## Prerequisites
- A running Kubernetes cluster (e.g., Talos, Kind, or Minikube);
- kubectl configured and connected to a cluster;
- Helm v3.9+ installed;


The Helm chart repository index (index.yaml) is hosted at:
  https://oxxenix.github.io/ServiceExample-copy/index.yaml


1. Add the Helm Repository
```
helm repo add serviceexample https://oxxenix.github.io/ServiceExample-copy
helm repo update
```

Verify it was added successfully:
```
helm search repo serviceexample
```

2. Create a Namespace

Create a dedicated namespace for the application:
```
kubectl create namespace serviceexample
```

3. Install the Helm Chart

Install the chart from the GitHub Pages Helm repository:
```
helm install serviceexample serviceexample/serviceexample \
  --namespace serviceexample \
  --version v0.1.1
```

If you want to customize configuration parameters:
```
helm install serviceexample serviceexample/serviceexample \
  -n serviceexample \
  -f charts/serviceexample/values.yaml
```

4. Upgrade or Uninstall

To apply updates from a newer version of the chart:
```
helm upgrade serviceexample serviceexample/serviceexample \
  -n serviceexample \
  --version v0.1.2
```

To uninstall the release:
```
helm uninstall serviceexample -n serviceexample
```

5. Verify Deployment

Check that all components are running correctly:
```
kubectl get pods -n serviceexample
kubectl get svc -n serviceexample
```

List all Helm releases:
```
helm list -n serviceexample
```

## Chart details
| **Property**     | **Value**                                                                                 |
|------------------|-------------------------------------------------------------------------------------------|
| **Name**         | `serviceexample`                                                                         |
| **Version**      | `v0.1.2`                                                                                 |
| **Published on** | [Artifact Hub](https://artifacthub.io/packages/helm/service-example/serviceexample)       |
| **Maintainer**   | `oxxenix`                                                                                |
| **Dependencies** | MongoDB, Redis, NATS    

## Helm Chart Verification
```
helm pull oci://ghcr.io/oxxenix/serviceexample --version v0.1.2 --prov --verify
```
