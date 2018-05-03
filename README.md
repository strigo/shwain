shwain
======

A sane logger for bash (WIP!)

Note that many features are not implemented yet and that some implementations are pure disgusting-ness.

## Usage

```text

$ ./shwain -h
Usage: shwain [OPTIONS] LEVEL MESSAGE [OBJECTS]...

Options:
  -j, --json         Use the JSON logger formatter instead of the console one
  -n, --name TEXT    Change the default logger's name
  --no-color         Disable coloring in console formatter
  --simple           Log only message to the console
  --enrich           Enrich with additional metadata like hostname, pid, etc..
  -h, --help         Show this message and exit.

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
[[ ! -f "shwain" ]] && curl -L -O https://github.com/nir0s/shwain/raw/master/shwain

. shwain

log.info woot a=b b=c c=d
...
```


## Errors levels supported

* event
* debug
* info
* warn
* warning
* error
* critical


## Env var based config

All flags are configurable via env vars:

```shell
export SHWAIN_flagname  # e.g. if `SHWAIN_JSON` is set, ...
# (`--no-color` is `SHWAIN_COLOR` wtf inconsistency).
```

## Tests

Currently tested by a group of dwarves inside my head.
