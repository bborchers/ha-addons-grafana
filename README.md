# ha-addons-grafana

Build repo for the Grafana Home Assistant add-on.

This repo automatically builds a multi-arch image on every published [release](https://github.com/bborchers/ha-addons-grafana/releases) and pushes it to `ghcr.io/bborchers/ha-addons-grafana`. The central repository [ha-addons](https://github.com/bborchers/ha-addons) is then automatically notified of the new version.

**To install in Home Assistant, please use [ha-addons](https://github.com/bborchers/ha-addons)**, not this repo directly — this repo is for building the image, not for distribution.

## Release process

1. Merge a PR (with label `major`, `minor`, or `patch`)
2. [Release Drafter](.github/workflows/release-drafter.yml) automatically updates a draft release with the next version
3. Publish the draft release → triggers build, GHCR push, and sync with `ha-addons`

See [grafana/DOCS.md](grafana/DOCS.md) for the add-on documentation and [grafana/CHANGELOG.md](grafana/CHANGELOG.md) for the version history.
