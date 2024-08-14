# syntax=docker/dockerfile:1

FROM golang:1.21-alpine AS builder

WORKDIR /app

COPY go.* ./
RUN go mod download

COPY . ./

COPY *.go ./

RUN go build -v -o /prusa_link_exporter

FROM alpine:latest

COPY --from=builder /prusa_link_exporter .

EXPOSE 10008

ENTRYPOINT ["/prusa_link_exporter"]