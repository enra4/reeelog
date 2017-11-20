# reeelog

reeeee

simple logging utility inspired by [log](https://github.com/nikersify/log)

![screenshot](screenshot.png)

./logs/foo.log
```
### app started 2017-11-19 15:18:09 +0100
(2017-11-19 15:18:09) [INFO] [APP] starting...
(2017-11-19 15:18:09) [SUCCESS] [APP] read config.json
(2017-11-19 15:18:09) [INFO] [APP] started in development mode
(2017-11-19 15:18:09) [INFO] [DB] attempting to connect...
(2017-11-19 15:18:09) [WARN] [DB] credentials missing, trying defaults...
(2017-11-19 15:18:09) [SUCCESS] [DB] connected!
(2017-11-19 15:18:09) [INFO] [HTTP] preparing html cache...
(2017-11-19 15:18:09) [SUCCESS] [HTTP] cache ready!
(2017-11-19 15:18:09) [ERROR] [HTTP] missing ssl certs
(2017-11-19 15:18:09) [INFO] [HTTP] server listening on port 3090
(2017-11-19 15:18:09) [TRACE] [HTTP] 54.73.249.176 POST /api/get_thing 400
(2017-11-19 15:18:09) [TRACE] [HTTP] 184.133.232.60 GET /
(2017-11-19 15:18:09) [TRACE] [HTTP] 184.133.232.60 GET /favicon.ico 404
(2017-11-19 15:18:09) [FATAL] [APP] spaghetti monster ate us
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
log = Reeelog.start("foo.log")
# logs will be saved at ./logs/foo.log
# if you dont want to save logs, simply dont call with an argument
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
# debug wont show in logfile
log.debug("uber debug msg!!")
log.trace("http", "184.133.232.60 GET /favicon.ico 404")
log.fatal("app", "spaghetti monster ate us")
```
