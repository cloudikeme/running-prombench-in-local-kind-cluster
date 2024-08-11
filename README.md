# Prombench in KIND Tutorial

In This repository ive created scripts and manifests to run Prombench tests in Kubernetes IN Docker (KIND).

## Quick Start

1. Clone this repository:
   ```
   git clone https://github.com/yourusername/prombench-kind.git
   cd prombench-kind
   ```

2. Set up the environment:
   ```
   source scripts/setup_env.sh
   ```

3. Create the KIND cluster:
   ```
   ./scripts/create_cluster.sh
   ```

4. Deploy monitoring components:
   ```
   ./scripts/deploy_monitoring.sh
   ```

5. Start a benchmark:
   ```
   ./scripts/start_benchmark.sh
   ```

For detailed instructions, please refer to the [setup guide](docs/setup.md) and [usage guide](docs/usage.md).

## Documentation

- [Setup Guide](docs/setup.md)
- [Usage Guide](docs/usage.md)
- [Troubleshooting](docs/troubleshooting.md)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
```



## docs/usage.md

```markdown
# Usage Guide

This guide explains how to use Prombench in KIND.

## Starting a Benchmark

To start a benchmarking test manually:

1. Set the required environment variables:
   ```
   export RELEASE=<master/main or any prometheus release(ex: v2.3.0)>
   export PR_NUMBER=<PR to benchmark against the selected $RELEASE>
   ```

2. Run the start_benchmark script:
   ```
   ./scripts/start_benchmark.sh
   ```

## Accessing Services

After deployment, services will be accessible at:

- Grafana: http://$INTERNAL_IP:$NODE_PORT/grafana
- Prometheus: http://$INTERNAL_IP:$NODE_PORT/prometheus-meta
- Logs: http://$INTERNAL_IP:$NODE_PORT/grafana/explore
- Profiles: http://$INTERNAL_IP:$NODE_PORT/profiles

## Deleting Benchmark Infrastructure

To delete the benchmark infrastructure:

```
./scripts/delete_cluster.sh
```

This will remove the KIND cluster and all associated resources.
```

## scripts/setup_env.sh

```bash
#!/bin/bash

# Prompt for and export required environment variables
read -p "Enter PR_NUMBER: " PR_NUMBER
read -p "Enter CLUSTER_NAME (default: prombench): " CLUSTER_NAME
CLUSTER_NAME=${CLUSTER_NAME:-prombench}
read -p "Enter GRAFANA_ADMIN_PASSWORD: " GRAFANA_ADMIN_PASSWORD
read -p "Enter DOMAIN_NAME (default: prombench.prometheus.io): " DOMAIN_NAME
DOMAIN_NAME=${DOMAIN_NAME:-prombench.prometheus.io}
read -p "Enter OAUTH_TOKEN (press enter to skip): " OAUTH_TOKEN
read -p "Enter WH_SECRET (press enter to skip): " WH_SECRET
read -p "Enter GITHUB_ORG (default: prometheus): " GITHUB_ORG
GITHUB_ORG=${GITHUB_ORG:-prometheus}
read -p "Enter GITHUB_REPO (default: prometheus): " GITHUB_REPO
GITHUB_REPO=${GITHUB_REPO:-prometheus}
read -p "Enter SERVICEACCOUNT_CLIENT_EMAIL: " SERVICEACCOUNT_CLIENT_EMAIL

# Export variables
export PR_NUMBER CLUSTER_NAME GRAFANA_ADMIN_PASSWORD DOMAIN_NAME OAUTH_TOKEN WH_SECRET GITHUB_ORG GITHUB_REPO SERVICEACCOUNT_CLIENT_EMAIL

echo "Environment variables set successfully."
```

## scripts/create_cluster.sh

```bash
#!/bin/bash

# Source environment variables
source scripts/setup_env.sh

# Create the KIND cluster
../infra/infra kind cluster create -v PR_NUMBER:$PR_NUMBER -v CLUSTER_NAME:$CLUSTER_NAME \
    -f manifests/cluster_kind.yaml

# Remove taint from control-plane node
kubectl --context kind-$CLUSTER_NAME taint nodes $CLUSTER_NAME-control-plane node-role.kubernetes.io/control-plane-

echo "KIND cluster created successfully."
```

## scripts/deploy_monitoring.sh

```bash
#!/bin/bash

# Source environment variables
source scripts/setup_env.sh

# Deploy monitoring components
../infra/infra kind resource apply -v CLUSTER_NAME:$CLUSTER_NAME -v DOMAIN_NAME:$DOMAIN_NAME \
    -v GRAFANA_ADMIN_PASSWORD:$GRAFANA_ADMIN_PASSWORD \
    -v OAUTH_TOKEN="$(printf $OAUTH_TOKEN | base64 -w 0)" \
    -v WH_SECRET="$(printf $WH_SECRET | base64 -w 0)" \
    -v GITHUB_ORG:$GITHUB_ORG -v GITHUB_REPO:$GITHUB_REPO \
    -v SERVICEACCOUNT_CLIENT_EMAIL:$SERVICEACCOUNT_CLIENT_EMAIL \
    -f manifests/cluster-infra

# Set NODE_NAME, INTERNAL_IP and NODE_PORT environment variables
export NODE_NAME=$(kubectl --context kind-$CLUSTER_NAME get pod -l "app=grafana" -o=jsonpath='{.items[*].spec.nodeName}')
export INTERNAL_IP=$(kubectl --context kind-$CLUSTER_NAME get nodes $NODE_NAME -o jsonpath='{.status.addresses[?(@.type=="InternalIP")].address}')
export NODE_PORT=$(kubectl --context kind-$CLUSTER_NAME get -o jsonpath="{.spec.ports[0].nodePort}" services grafana)

echo "Monitoring components deployed successfully."
echo "Grafana: http://$INTERNAL_IP:$NODE_PORT/grafana"
echo "Prometheus: http://$INTERNAL_IP:$NODE_PORT/prometheus-meta"
echo "Logs: http://$INTERNAL_IP:$NODE_PORT/grafana/explore"
echo "Profiles: http://$INTERNAL_IP:$NODE_PORT/profiles"
```

## scripts/start_benchmark.sh

```bash
#!/bin/bash

# Source environment variables
source scripts/setup_env.sh

# Prompt for RELEASE if not set
if [ -z "$RELEASE" ]; then
    read -p "Enter RELEASE (master/main or prometheus release, e.g., v2.3.0): " RELEASE
    export RELEASE
fi

# Deploy the k8s objects for benchmarking
../infra/infra kind resource apply -v CLUSTER_NAME:$CLUSTER_NAME \
    -v PR_NUMBER:$PR_NUMBER -v RELEASE:$RELEASE -v DOMAIN_NAME:$DOMAIN_NAME \
    -v GITHUB_ORG:${GITHUB_ORG} -v GITHUB_REPO:${GITHUB_REPO} \
    -f manifests/prombench/benchmark

echo "Benchmark started successfully."
```

This tutorial and repository structure provides a comprehensive guide to setting up and running Prombench in KIND. The scripts automate most of the process, making it easier for users to get started. The documentation explains each step and provides troubleshooting guidance.

To complete the repository, you would need to:

1. Create the actual manifest files in the `manifests/` directory.
2. Implement the `infra` tool or provide instructions for obtaining it.
3. Add a license file.
4. Create a CI workflow in `.github/workflows/ci.yml` to test the scripts and deployment process.
5. Expand the troubleshooting guide with common issues and their solutions.

This structure allows for easy maintenance and contribution, while providing users with a clear path to get Prombench running in KIND.