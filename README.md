shwain
======

[![Circle CI](https://circleci.com/gh/strigo/shwain.svg?style=shield)](https://circleci.com/gh/strigo/shwain)

`bash` sucks. Everyone uses `bash`. Here's a sane logger for `bash`.

Note that the following documentation relates to the code currently in the master branch. If you want to view docs for previous versions, please choose the relevant release in the "releases" tab.

AFAIK, shwain only supports bash 4+. If you want a logger for zsh, sh, ksh, tcsh, fish, or whatever else you think will make you live-a-little-bit-longer-but-still-on-the-verge-of-a-nervous-breakdown, submit a PR.


## Installation

```bash
Install locally:

[[ ! -f "shwain" ]] && \
	curl -LO https://github.com/strigo/shwain/raw/master/shwain && \
	chmod +x shwain

or directly to your path (Yes, we sudo):

[[ ! -f "/usr/bin/shwain" ]] && \
	sudo curl -L https://github.com/strigo/shwain/raw/master/shwain -o /usr/bin/shwain && \
	sudo chmod +x /usr/bin/shwain
```

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

$ ./shwain debug "My message"
2018-05-04 09:41:44 - SHWAIN - DEBUG - My message

$ ./shwain info w00t a=b b=c c=d
2018-05-02 09:54:38 - SHWAIN - INFO - w00t
  a=b
  b=c
  c=d

$ ./shwain error message kern="$(uname -a)" -e -j --aws
{
  "kern": "Linux nir0s-x1 4.10.0-42-generic #46-Ubuntu ...",
  "pid": "11480",
  "hostname": "nir0s-x1",
  "type": "log",
  "timestamp": "2018-05-03 09:16:01",
  "name": "SHWAIN",
  "level": "ERROR",
  "message": "message",
  "ec2_instance_id"="i-0074c2ab2bf9e0a31",
  "ec2_instance_type"="t2.micro",
  "ec2_region"="eu-west-1b",
  "ec2_ipv4"="172.16.46.73"
}

...

```

From a script:

```bash
. shwain

log.info woot a=b b=c c=d
# See more error levels below, which directly map into additional functions.
...

```

Don't, forget, bash, expansion, everywhere. Spaces are evil.

Note that you can't pass flags to the functions when sourcing. To configure shwain when sourcing, use env vars (see [Env var based config](#env-var-based-config)).



## Supported errors levels

* `event`
* `debug`
* `info`
* `warning`
* `warn`
* `error`
* `critical`

When using the CLI, both upper and lower case will work.


## Env var based config

All flags are configurable via env vars:

```shell
export SHWAIN_FLAG_NAME  # e.g. if `SHWAIN_JSON` is set, ... dashes are underscores.
```

## Context enrichment

Using the `-e` flag or setting the `SHWAIN_ENRICH` env var will make shwain add several fields to each message's context, namely, `pid` and `hostname`.

### If in an EC2 instance

shwain will add several fields related to the instance it is running on. See example in [usage](#usage).


## Coloring

Error levels will be colored according to the following mapping:

```bash
declare -A COLOR_MAPPING=(
  ["DEBUG"]="0;36"    # CYAN
  ["INFO"]="0;32"     # GREEN
  ["WARNING"]="1;33"  # YELLOW
  ["WARN"]="1;33"     # YELLOW
  ["ERROR"]="0;31"    # RED
  ["CRITICAL"]="1;31" # BRIGHT RED
  ["EVENT"]="1;32"    # BRIGHT GREEN
)
```

You can disable coloring by using the `--no-color` flag or setting the `SHWAIN_NO_COLOR` env var.


## Tests

To run tests locally:

```shell
$ npm install bats
...
$ git submodule init
$ git submodule update --remote
$ node_modules/bats/bin/bats test/*.bats
```

