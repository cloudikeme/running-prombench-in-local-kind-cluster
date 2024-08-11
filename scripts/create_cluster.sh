#!/bin/bash

# Source environment variables
source scripts/setup_env.sh

# Create the KIND cluster
../infra/infra kind cluster create -v PR_NUMBER:$PR_NUMBER -v CLUSTER_NAME:$CLUSTER_NAME \
    -f manifests/cluster_kind.yaml

# Remove taint from control-plane node
kubectl --context kind-$CLUSTER_NAME taint nodes $CLUSTER_NAME-control-plane node-role.kubernetes.io/control-plane-

echo "KIND cluster created successfully."