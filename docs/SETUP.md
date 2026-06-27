# Self-Hosted Runner Setup

This project uses a GitHub Actions self-hosted runner on the production VM
(`192.168.56.11`) to deploy code automatically after a successful CI run.
Together with the workflow in `.github/workflows/ci.yml`, this provides
Continuous Deployment for PixelWise.

## Prerequisites on the prod VM

- Ubuntu 24.04 LTS, user `produser` with sudo
- PixelWise repository cloned to `/opt/pixelwise`
- Virtual environment at `/opt/pixelwise/.venv`
- Model artefact `digit_classifier_v1.pkl` under `/opt/pixelwise/models/`
- `.env` file with `MODEL_PATH=models/digit_classifier_v1.pkl`

## Quick start

1. Generate a registration token at
   https://github.com/HanDre13/pixelwise/settings/actions/runners
   (*New self-hosted runner*, Linux, x64; valid for 90 minutes).

2. On the prod VM as `produser`, from the repository root:

       ./setup-runner.sh <TOKEN>

3. Start the runner:

       cd ~/actions-runner && ./run.sh

   The terminal prints `Listening for Jobs`. Subsequent pushes to `main`
   that pass CI will be deployed automatically.

To target a different repository, pass its URL as a second argument:

    ./setup-runner.sh <TOKEN> https://github.com/<user>/<repo>

## Notes

- The deploy job is gated to direct pushes on `main` only (not pull
  requests), which prevents fork-based code from reaching the runner.
- For long-term use, the runner can be installed as a systemd service
  via the bundled `svc.sh` script. This is out of scope for the current
  project.

See `.github/workflows/ci.yml` for the full pipeline definition.
