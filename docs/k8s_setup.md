#Re-Setting Up the Kubernetes Cluster (Talos + Flux + Hetzner)

This guide describes how to rebuild a Kubernetes cluster on Hetzner Cloud using Talos Linux and manage it with FluxCD (GitOps).

## Prerequisites
- [A Hetzner Cloud account](https://accounts.hetzner.com/login) and API token
- Installed CLI tools:
brew install talosctl kubectl fluxcd/tap/flux hcloud

Flux will use the branch flux-gitops for cluster configuration.

1. Create Cluster Nodes

```
hcloud server create --name cp-1 --image talos-v1.11.0 --type cpx31 --ssh-key <your_ssh_key>
hcloud server create --name worker-1 --image talos-v1.11.0 --type cpx31 --ssh-key <your_ssh_key>
```

2. Generate and Apply Talos Configs
```
talosctl gen config mycluster https://<control-plane-ip>:6443 \
  --output-dir _out --with-secrets

talosctl apply-config --insecure --nodes <control-plane-ip> --file _out/controlplane.yaml
talosctl apply-config --insecure --nodes <worker-ip> --file _out/worker.yaml
```

Bootstrap the cluster:
```
talosctl bootstrap --nodes <control-plane-ip> --endpoints <control-plane-ip>
```

Check health:

```
talosctl health
```

Retrieve kubeconfig:
```
talosctl kubeconfig .
export KUBECONFIG=$(pwd)/kubeconfig
```

3. Install Hetzner Cloud Controller Manager (CCM) & CSI

Add your Hetzner API token:

export HCLOUD_TOKEN=<your_token>
kubectl -n kube-system create secret generic hcloud --from-literal=token=$HCLOUD_TOKEN


Install the controllers:

kubectl apply -f https://github.com/hetznercloud/hcloud-cloud-controller-manager/releases/latest/download/ccm.yaml
kubectl apply -f https://github.com/hetznercloud/csi-driver/releases/latest/download/deploy.yaml

4. Bootstrap FluxCD
```
flux bootstrap github \
  --owner="owner name"\
  --repository=ServiceExample-copy \
  --branch=flux-gitops \
  --path=clusters/mycluster \
  --personal
```

Check that all controllers are healthy:
```
flux get kustomizations --watch
kubectl get pods -n flux-system
```

Flux automatically syncs configs and Helm releases from Git (flux-gitops branch).

All apps, infrastructure and secrets are recreated declaratively.


## References:
- [Install Hetzner Cloud Controller Manager](https://docs.siderolabs.com/talos/v1.11/platform-specific-installations/cloud-platforms/hetzner#install-hetzners-cloud-controller-manager)
- [Hetzner Cloud CLI](https://github.com/hetznercloud/cli)
