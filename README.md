shwain
======

A sane logger for bash (WIP!)

Note that many features are not implemented yet and that some implementations are pure disgusting-ness.

## Usage

```shell
$ ./shwain info w00t a=b b=c c=d
2018-05-02 09:54:38 - SHWAIN - INFO - w00t
  a=b
  b=c
  c=d
  pid=22191
  hostname=nir0s-x1
  type=log
...
```

From a script:

```bash
. shwain

log.info woot a=b b=c c=d
...
```


## Errors levels supported

* trace
* debug
* info
* warn
* warning
* error
* critical

## Some flags for now

* `--simple` -> try it out. no enrichment.
* `--json` -> print json instead.
* `--no-color` -> um.. no.. color?
* `--name` -> the logger name to use.

Env vars are also available for when sourcing: e.g. `--simple` -> `export SHWAIN_SIMPLE` (`--no-color` is `SHWAIN_COLOR` wtf inconsistency).
