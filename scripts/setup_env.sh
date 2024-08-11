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
