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



This tutorial and repository structure provides a comprehensive guide to setting up and running Prombench in KIND. The scripts automate most of the process, making it easier for users to get started. The documentation explains each step and provides troubleshooting guidance.

To complete the repository, you would need to:

1. Create the actual manifest files in the `manifests/` directory.
2. Implement the `infra` tool or provide instructions for obtaining it.
3. Add a license file.
4. Create a CI workflow in `.github/workflows/ci.yml` to test the scripts and deployment process.
5. Expand the troubleshooting guide with common issues and their solutions.

This structure allows for easy maintenance and contribution, while providing users with a clear path to get Prombench running in KIND.