# ha-addons-grafana

![project stage](https://img.shields.io/badge/project%20stage-experimental-yellow)

Build repo for the Grafana Home Assistant add-on.

This add-on is in an early, experimental stage — expect rough edges and breaking changes between releases.

This repo automatically builds a multi-arch image on every published [release](https://github.com/bborchers/ha-addons-grafana/releases) and pushes it to `ghcr.io/bborchers/ha-addons-grafana`. The central repository [ha-addons](https://github.com/bborchers/ha-addons) is then automatically notified of the new version.

**To install in Home Assistant, please use [ha-addons](https://github.com/bborchers/ha-addons)**, not this repo directly — this repo is for building the image, not for distribution.

## Release process

1. In your PR, add the [grafana/CHANGELOG.md](grafana/CHANGELOG.md) entry for the version this PR will produce — i.e. the current latest release bumped by the label you're about to apply (major/minor/patch)
2. Merge the PR (with label `major`, `minor`, or `patch`)
3. [Release Drafter](.github/workflows/release-drafter.yml) automatically updates a draft release with the next version
4. Publish the draft release → triggers build, GHCR push, and sync with `ha-addons`

**Do not add a changelog entry in a follow-up PR after the release.** Merging that follow-up PR triggers Release Drafter again for the *next* version, so the changelog permanently lags one version behind — always bump the changelog in the same PR as the change it describes.

See [grafana/DOCS.md](grafana/DOCS.md) for the add-on documentation and [grafana/CHANGELOG.md](grafana/CHANGELOG.md) for the version history.
