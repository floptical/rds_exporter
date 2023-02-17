== How to run ==

Build it:

`docker build -t rds_exporter:latest .`

Make a directory for a bind mount:

`mkdir ./rds_config`

Run the command with the absolute path to the config folder

```
current_dir=$(pwd)
docker run --name rds_exporter -v $current_dir/config:/etc/rds_exporter/ rds_exporter:latest
```

== Run with Docker Compose ==

Clone: 

`git clone https://github.com/floptical/rds_exporter ./rds_exporter_build`

Setup your rds config dir as described above and then in your compose file,

```
  rds-exporter:
    build:
      context: ./rds_exporter_build
    image: percona/rds-exporter:latest
    volumes:
      - /home/ubuntu/prometheus/rds-config/:/etc/rds_exporter/
      - /proc:/host/proc:ro
      - /sys:/host/sys:ro
      - /:/rootfs:ro
    ports:
      - 9042:9042
    deploy:
      mode: global
      restart_policy:
          condition: on-failure
```
