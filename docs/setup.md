# Setup Guide

This guide will walk you through setting up Prombench in KIND.

## Prerequisites

- Docker
- kubectl
- kind
- infra tool (from prombench repository)

## Steps

1. Install KIND:
   ```
   GO111MODULE="on" go get sigs.k8s.io/kind@v0.11.1
   ```

2. Set up environment variables:
   ```
   source scripts/setup_env.sh
   ```
   This script will prompt you to enter necessary values for environment variables.

3. Create the KIND cluster:
   ```
   ./scripts/create_cluster.sh
   ```

4. Deploy monitoring components:
   ```
   ./scripts/deploy_monitoring.sh
   ```

After completing these steps, your Prombench environment in KIND should be ready for use.
