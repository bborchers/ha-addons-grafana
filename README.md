# ha-addons-grafana

Build-Repo für das Grafana Home-Assistant-Addon.

Dieses Repo baut bei jedem veröffentlichten [Release](https://github.com/bborchers/ha-addons-grafana/releases) automatisch ein Multi-Arch-Image und pusht es nach `ghcr.io/bborchers/grafana`. Anschließend wird das zentrale Repository [ha-addons](https://github.com/bborchers/ha-addons) automatisch über die neue Version informiert.

**Zur Installation in Home Assistant bitte [ha-addons](https://github.com/bborchers/ha-addons) verwenden**, nicht dieses Repo direkt — dieses Repo dient dem Bauen des Images, nicht der Distribution.

## Release-Prozess

1. PR mergen (mit Label `major`, `minor` oder `patch`)
2. [Release Drafter](.github/workflows/release-drafter.yml) aktualisiert automatisch einen Draft-Release mit der nächsten Version
3. Draft-Release veröffentlichen → löst Build, GHCR-Push und Sync mit `ha-addons` aus

Siehe [grafana/DOCS.md](grafana/DOCS.md) für die Addon-Dokumentation und [grafana/CHANGELOG.md](grafana/CHANGELOG.md) für die Versionshistorie.
