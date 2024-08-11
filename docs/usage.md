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