# reeelog

reeeee
simple logging utility inspired by [log](https://github.com/nikersify/log)

![screenshot](screenshot.png)

reeelog.log
```sh
### app started 2017-11-18 22:03:19 +0100
(2017-11-18 22:03:19) [APP] starting...
(2017-11-18 22:03:19) [APP] read config.json
(2017-11-18 22:03:19) [APP] started in development mode
(2017-11-18 22:03:19) [DB] attempting to connect...
(2017-11-18 22:03:19) [DB] credentials missing, trying defaults...
(2017-11-18 22:03:19) [DB] connected!
(2017-11-18 22:03:19) [HTTP] preparing html cache...
(2017-11-18 22:03:19) [HTTP] cache ready!
(2017-11-18 22:03:19) [HTTP] missing ssl certs
(2017-11-18 22:03:19) [HTTP] server listening on port 3090
(2017-11-18 22:03:19) [HTTP] 54.73.249.176 POST /api/get_thing 400
(2017-11-18 22:03:19) [HTTP] 184.133.232.60 GET /
(2017-11-18 22:03:19) [HTTP] 184.133.232.60 GET /favicon.ico 404
(2017-11-18 22:03:19) [APP] spaghetti monster ate us
```

## installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  reeelog:
    github: enra4/reeelog
```

## usage

```crystal
require "reeelog"
```

```crystal
log = Reeelog.start(true)
# true because we want to write logs to file(reeelog.log)
log.info("app", "starting...")
log.success("app", "read config.json")
log.info("app", "started in development mode")
log.info("db", "attempting to connect...")
log.warn("db", "credentials missing, trying defaults...")
log.success("db", "connected!")
log.info("http", "preparing html cache...")
log.success("http", "cache ready!")
log.error("http", "missing ssl certs")
log.info("http", "server listening on port 3090")
log.trace("http", "54.73.249.176 POST /api/get_thing 400")
log.trace("http", "184.133.232.60 GET /")
log.trace("http", "184.133.232.60 GET /favicon.ico 404")
log.fatal("app", "spaghetti monster ate us")
```
