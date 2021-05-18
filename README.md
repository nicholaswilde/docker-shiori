# Docker Template
[![Docker Image Version (latest by date)](https://img.shields.io/docker/v/nicholaswilde/shiori)](https://hub.docker.com/r/nicholaswilde/shiori)
[![Docker Pulls](https://img.shields.io/docker/pulls/nicholaswilde/shiori)](https://hub.docker.com/r/nicholaswilde/shiori)
[![GitHub](https://img.shields.io/github/license/nicholaswilde/docker-shiori)](./LICENSE)
[![ci](https://github.com/nicholaswilde/docker-shiori/workflows/ci/badge.svg)](https://github.com/nicholaswilde/docker-shiori/actions?query=workflow%3Aci)
[![lint](https://github.com/nicholaswilde/docker-shiori/workflows/lint/badge.svg?branch=main)](https://github.com/nicholaswilde/docker-shiori/actions?query=workflow%3Alint)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

A multi-architecture image for [shiori](https://github.com/go-shiori/shiori).

## Architectures

* [x] `armv7`
* [x] `arm64`
* [x] `amd64`

## Dependencies

* sqlite3
* mysql (optional)
* postgres (optional)

## Usage

### docker cli

```bash
$ docker run -d \
  --name=shiori-default \
  -e TZ=America/Los_Angeles `# optional` \
  -e PUID=1000        `# optional` \
  -e PGID=1000        `# optional` \
  -e SHIORI_DIR=/data `# optional` ]
  -p 8080:8080 \
  --restart unless-stopped \
  nicholaswilde/shiori
```

### docker-compose

* [sqlite3](./docker-compose.sqlite3.yaml)
* [mysql](./docker-compose.mysql.yaml)
* [postgres](./docker-compose.postres.yaml)

## Configuration

### Default Web Interface

| username | password |
|---------:|:---------|
| shiori   |  gopher  |

### Volumes

| user | uid |
|-----:|:---:|
| abc  | 911 |

## Development

See [docs](https://nicholaswilde.io/docker-docs/development).

## Troubleshooting

See [docs](https://nicholaswilde.io/docker-docs/troubleshooting).

## Pre-commit hook

If you want to automatically generate `README.md` files with a pre-commit hook, make sure you
[install the pre-commit binary](https://pre-commit.com/#install), and add a [.pre-commit-config.yaml file](./.pre-commit-config.yaml)
to your project. Then run:

```bash
$ pre-commit install
$ pre-commit install-hooks
```
Currently, this only works on `amd64` systems.

## License

[Apache 2.0 License](./LICENSE)

## Author
This project was started in 2021 by [Nicholas Wilde](https://github.com/nicholaswilde/).
