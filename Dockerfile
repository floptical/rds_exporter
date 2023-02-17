FROM golang:1.20.1-alpine3.17 as builder

RUN apk update && apk add git make

RUN git clone https://github.com/percona/rds_exporter.git /rds_exporter

WORKDIR /rds_exporter

RUN go build

##############################################################

FROM alpine:3.10

COPY --from=builder /rds_exporter/rds_exporter /bin/

RUN mkdir /etc/rds_exporter

EXPOSE      9042
ENTRYPOINT  [ "/bin/rds_exporter", "--config.file=/etc/rds_exporter/config.yml" ]
