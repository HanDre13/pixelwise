#!/bin/bash
# setup-runner.sh - install and register the GitHub Actions
# self-hosted runner for PixelWise on a fresh prod VM.
#
# Usage:
#   ./setup-runner.sh <REGISTRATION_TOKEN> [REPO_URL]
#
# REPO_URL is optional and defaults to https://github.com/HanDre13/pixelwise
#
# Get a token at:
#   <REPO_URL>/settings/actions/runners
#   -> New self-hosted runner (Linux, x64) -> copy token (valid 90 min)
#
# After this script finishes, start the runner with:
#   cd ~/actions-runner && ./run.sh
set -euo pipefail

if [ $# -lt 1 ] || [ $# -gt 2 ]; then
    echo "Usage: $0 <REGISTRATION_TOKEN> [REPO_URL]"
    echo "  REPO_URL defaults to https://github.com/HanDre13/pixelwise"
    exit 1
fi

TOKEN="$1"
REPO_URL="${2:-https://github.com/HanDre13/pixelwise}"
RUNNER_VERSION="2.335.1"
RUNNER_DIR="$HOME/actions-runner"

# Create the runner directory and switch to it.
mkdir -p "$RUNNER_DIR"
cd "$RUNNER_DIR"

# Download and extract the runner only if it is not already present.
if [ ! -f "config.sh" ]; then
    echo "==> Downloading GitHub Actions runner v${RUNNER_VERSION}..."
    curl -o "actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz" -L \
        "https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz"
    tar xzf "./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz"
else
    echo "==> Runner already extracted, skipping download."
fi

# Register the runner with GitHub in unattended mode.
# --replace allows re-running the script to re-register an existing runner.
echo "==> Registering runner with GitHub at ${REPO_URL}..."
./config.sh \
    --unattended \
    --url "$REPO_URL" \
    --token "$TOKEN" \
    --name "pixelwise-prod-runner" \
    --labels "pixelwise-prod" \
    --work "_work" \
    --replace

echo ""
echo "==> Runner registered successfully."
echo "==> Start it with: cd $RUNNER_DIR && ./run.sh"
