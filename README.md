# Gin Vals

Vals in a Gin Webserver

## Usage

### Simple single value GET request

```yaml
test:
  image: bitnami/bitnami-shell:latest
  services:
    - name: patrickdomnick/gin-vals:latest
      alias: ginvals
  script:
    - export secret=$(curl -X GET "http://ginvals:9090/ref+echo://foo/bar")
```

### Simple single value POST request

```yaml
test:
  image: bitnami/bitnami-shell:latest
  services:
    - name: patrickdomnick/gin-vals:latest
      alias: ginvals
  script:
    - export secretJson=$(curl -H 'Content-Type: application/json' -d '{"foo": "ref+echo://foo/bar","bar": "ref+echo://bar/foo"}' -X POST "http://ginvals:9090")
```

## Roadmap

TODO

## Contribution

TODO

## Authors and acknowledgment

- [Vals](https://github.com/variantdev/vals)
- [Gin](https://github.com/gin-gonic/gin)

## License

[Apache License](/LICENSE)