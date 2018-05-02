shwain
======

A sane logger for bash (WIP!)

Note that many features are not implemented yet and that some implementations are pure disgusting-ness.

## Usage

```text

$ ./shwain -h
Usage: shwain [OPTIONS] LEVEL MESSAGE [OBJECTS]...

Options:
  --pretty / --ugly  Output JSON instead of key=value pairs for console logger
  -j, --json         Use the JSON logger formatter instead of the console one
  -n, --name TEXT    Change the default logger's name
  --no-color         Disable coloring in console formatter
  --simple           Log only message to the console
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
