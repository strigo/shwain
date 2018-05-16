## 0.1.0 (2018.05.16)

* Initial release
* Support namespaced functions (e.g. `log.info`, `log.error`) when sourcing.
* Support CLI execution (e.g. `shwain warn "My Warning Message"`)
* Support JSON formatting.
* Allow configuring most aspects of the logger via env vars.
* Support enriching with metadata via CLI flag or env var.
* Support enrching with EC2 instance-specific metadata when available.
* Color severity levels accordingly.
* Support `event` severity type.
