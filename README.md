# Accessing external Secrets in Gitlab CI

There are times when you want to access your existing credentials from a secure location, like [Vault by HashiCorp](https://www.vaultproject.io/), [AWS](https://aws.amazon.com/) or some other big Cloud provider but your current CI Image does not have the necessary SDK installed or means to retrieve them. Maintaining them a second time as Gitlab Variables or accessing them in a previous job should not be done and is considered insecure for many reasons. That is why I created [Gin Vals](https://gitlab.com/PatrickDomnick/gin-vals). Simply run Gin Vals as an Service and make a Web Request to the service.

## Concept

As the name describes Gin Vals combines to simple GO dependencies to create a slim and easy solution for most providers.
[Vals by Variantdev](https://github.com/variantdev/vals) is a tool for managing configuration values and secrets for the major cloud providers and other technologies.
Now we simply need to make it accessible via REST with the Gin [Web Framework](https://github.com/gin-gonic/gin).

## Usage

Because we are using Vals as our configuration and secrets tool, we can simply refer to its [documentation](https://github.com/variantdev/vals#supported-backends):

- Vault: `ref+vault://PATH/TO/KVBACKEND%23/fieldkey`
- AWS Secrets Manager: `ref+awssecrets://PATH/TO/SECRET%23/fieldkey`
- GCP Secrets Manager: `ref+gcpsecrets://PROJECT/SECRET`
- and many more...

I will use the simple `echo` method to display some possible methods of using Gin Vals.

### Simple single value GET request

The easiest way is to just retrieve one secret via GET. Add the Vals string as path and you should be able to get your secret value into a variable.

```yaml
test:
  image: bitnami/bitnami-shell:latest
  services:
    - name: patrickdomnick/gin-vals:latest
      alias: ginvals
  script:
    - export secret=$(curl -X GET "http://ginvals:9090/ref+echo://foo/bar")
    - echo secret
```

### Simple single value POST request

The more advanced method would be to retrieve many secrets at once as a json object. From here we could parse the data with tools like jq depending on the main image you are using.

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

- Automated Testing

## Contribution

TODO

## Authors and acknowledgment

- [Vals](https://github.com/variantdev/vals)
- [Gin](https://github.com/gin-gonic/gin)

## License

[Apache License](/LICENSE)
