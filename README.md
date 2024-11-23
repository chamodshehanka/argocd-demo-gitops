# argocd-demo-gitops
Argo CD Demo GitOps Repo

## Argo CD Installation

### Prerequisites

- Kubernetes Cluster
- kubectl
- Argo CD CLI

### Install Argo CD

Install Argo CD using the script `install-argocd.sh`:
```bash
chmod +x install-argocd.sh
./install-argocd.sh
```

or follow the official [Argo CD Installation Guide](https://argo-cd.readthedocs.io/en/stable/getting_started/).

### Access Argo CD UI

```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

Open the browser and navigate to `https://localhost:8080` and login with the default username and password:

- Username: `admin`
- Password: `kubectl get pods -n argocd -l "app.kubernetes.io/name=argocd-server" -o name | cut -d'/' -f 2`

### Create an Application

Create an application using the Argo CD GUI or CLI.

```bash
argocd app create my-app --repo
```

### Sync an Application

Sync an application using the Argo CD GUI or CLI.

```bash
argocd app sync my-app
```

