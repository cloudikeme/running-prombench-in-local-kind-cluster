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