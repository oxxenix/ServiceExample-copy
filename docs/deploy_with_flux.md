# Deploying the Application via GitOps (FluxCD)

This repository uses FluxCD to automatically deploy the ServiceExample application into Talos-based Kubernetes cluster using the GitOps approach.

## Prerequisites
- Talos cluster is up and running (see [K8s_setup](k8s_setup.md)).
- FluxCD is installed and bootstrapped with a Git repository.
- Helm chart of application is published to GitHub Pages:

## Managed applications:

Core Components:

| Component | Description |
|------------|-------------|
| **csi-driver** | Provides CSI (Container Storage Interface) integration for persistent volume management. |
| **local-path-provisioner** | Simple local storage provisioner for dynamic PersistentVolume creation. |
| **longhorn** | Distributed block storage system providing resilient and replicated storage for workloads. |
| **monitoring stack** | Full observability suite including:<br>• Grafana<br>• VictoriaMetrics Operator<br>• VictoriaMetrics Kubernetes Stack<br>• VictoriaLogs Single |
| **sealed-secrets** | Enables secure management of Kubernetes Secrets by encrypting them for storage in Git. |


## Steps needed to deploy an app:
Step 1: Define Helm Repository
Step 2: Define HelmRelease
Step 3: Secrets (Optional)

```
kubectl create secret generic serviceexample-secrets \
  -n serviceexample \
  --from-literal=DB_PASSWORD=supersecure \
  --dry-run=client -o yaml > secret.yaml
```
```
kubeseal --format=yaml --cert=pub-sealed-secrets.pem \
  < secret.yaml > sealed-serviceexample-secrets.yaml
```

Step 4: Push Changes
Step 5: Verify Deployment

```
flux get helmrelease -A
```

Check running pods:
```
kubectl get pods -n serviceexample
```
