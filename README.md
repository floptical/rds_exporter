# Use

Made this to quickly make a working Docker container for [Percona's rds-exporter](https://github.com/percona/rds_exporter/blob/main/config/config.go#L20-L29) because they removed their official one off Docker Hub for some reason.
The Dockerfile in their repo also doesn't build because it expects a compiled binary from the go source code. So my Dockerfile compiles it.

# How to run

Build it:

`docker build -t rds_exporter:latest .`

Make a directory for a bind mount:

`mkdir ./rds_config`

Make a 'config.yml' file based off their README docs.

Run the Docker command with the absolute path to the config folder

```
current_dir=$(pwd)
docker run --name rds_exporter -v $current_dir/rds-config/:/etc/rds_exporter/ rds_exporter:latest
```

# Run with Docker Compose

Clone: 

`git clone https://github.com/floptical/rds_exporter ./rds_exporter_build`

Setup your rds config directory as described above and then in your compose file,

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
