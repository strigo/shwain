shwain
======

A sane logger for bash (WIP!)

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

```bash
. shwain

log.info woot a=b b=c c=d
...
```
