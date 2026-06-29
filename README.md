# PixelWise

PixelWise is a small Python application that classifies handwritten digits
from the MNIST dataset using a pre-trained model. It is developed throughout
the "Methoden und Werkzeuge der Softwareentwicklung" course at DHBW Ravensburg.

This repository extends the course material with a working CI/CD pipeline
using GitHub Actions, including automated testing, linting, coverage
reporting, and automated deployment to a self-hosted runner on a production VM.

## Structure

- `app/` — classifier module
- `tests/` — pytest test suite
- `models/` — model artefacts (downloaded by the pipeline at runtime)
- `.github/workflows/` — CI/CD pipeline definition
- `docs/SETUP.md` — setup instructions for the self-hosted runner
- `setup-runner.sh` — idempotent installation script for the runner
- `setup-server.sh` — base server setup (from Block 3)
- `predict.py` — smoke test script used in the deployment stage

## Reproducing the pipeline

The CI stage runs automatically on every push and pull request and requires
no local setup.

To set up the self-hosted runner on a fresh production VM:

1. Fetch a runner registration token from the repository settings.
2. Run `setup-runner.sh` with the token.
3. Start the runner with `./run.sh`.

See `docs/SETUP.md` for detailed instructions.

## Project Report

This repository accompanies a project report submitted as part of the WDS225
module. The report describes the implementation, results, and limitations
of the CI/CD pipeline in detail.
