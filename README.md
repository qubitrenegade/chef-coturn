# coturn

This cookbook installs and configures [Coturn](https://github.com/coturn/coturn) a [TURN Server](https://en.wikipedia.org/wiki/Traversal_Using_Relays_around_NAT) written in C.

Currently this cookbook only supports Ubuntu package based installs with plans to support CentOS in the future.

***!!!THIS COOKBOOK REQUIRES YOU USE AN SSL CERTIFICATE WITH COTURN!!!***

This cookbook is a WIP, #1 - ([issue 1](https://github.com/qubitrenegade/chef-coturn/issues/1)) tracks making `static-auth-secret` set via property.

## Quickstart

As this cookbook was designed to be used with [`certbot-exec`](https://supermarket.chef.io/cookbooks/certbot-exec), the easiest way to get started is:

Add the following to your `metadata.rb`:

```ruby
depends 'certbot-exec'
depends 'certbot-exec-cloudflare'
depends 'coturn'
```

Then create your certificate and coturn server:

```ruby
node.default['my_coturn']['domain'] = 'turn.mydomain.com'

certbot_exec node['my_coturn']['domain']
coturn_server node['my_coturn']['domain']
```

### Demo

To see it in action, test/fixtures/cookbooks/test-coturn is a cookbook designed to demo/test this cookbook, leveraging `certbot-exec` and `certbot-exec-cloudflare` to generate the SSL certifiacate.

Create an "environment file":

```bash
export CF_API_KEY='your cloudflare global api key'
export CF_EMAIL='your cloudflare email'

# make sure to use a subdomain!
export CHEF_COTURN_DOMAIN='turn.domain-managed-by-cloudflare.com'
```

Then run test kitchen, this leverages InSpec to validate the installation of Coturn:

```bash
kitchen converge
kitchen verify
kitchen test
```

## Usage

This cookbook provides a resource `coturn_server` that installs `coturn`, sets up the requisite config files, and starts the service.

The `coturn_server` resource assumes the use of `certbot-exec` for SSL generation and defaults to using the `certbot-exec` Ohai plugin to find the SSL certificate.  This behavior can be overridden by setting the `ssl_cert_path` and `ssl_key_path` properties.

This cookbook does not provide any recipes.

### Resource `coturn_server`

#### Syntax

```ruby
coturn_server 'name' do
  server_name                String # FQDN of Turn Server, defaults to 'name' if not specified
  ssl_cert_path              String # (Optional) defaults to node['certbot']['ssl_cert_path']
  ssl_key_path               String # (Optional) defaults to node['certbot']['ssl_key_path']
  action                     Symbol # defaults to :create if not specified
end
```

#### Actions

&nbsp;&nbsp;&nbsp;&nbsp;`:create`

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;setup the TURN server

&nbsp;&nbsp;&nbsp;&nbsp;`:remove`

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;tear down the TURN server and supporting files.

#### Properties

&nbsp;&nbsp;&nbsp;&nbsp;`server_name`

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;FQDN of the TURN server, typically this is a subdomain, e.g.: `turn.example.com`

&nbsp;&nbsp;&nbsp;&nbsp;`ssl_cert_path`

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Full path to SSL certificate on disk.  Only needs to be readable by `root`

## Contributing

Please open an [issue](https://github.com/qubitrenegade/chef-coturn/issues) for any bugs, problems, questions, or feature requests.

All PRs welcome!  (feature requests may be met with requests for a PR!)

## License

```
The MIT License (MIT)

Copyright (c) 2019 Qubit Renegade

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```