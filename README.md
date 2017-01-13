# acmesmith-designate

This gem is a plugin for [Acmesmith](https://github.com/sorah/acmesmith) and implements an automated `dns-01` challenge responder using OpenStack Designate.
It currently only supports Designate v1 API and tested with [ConoHa](https://www.conoha.jp/conoha).

With this plugin and Acmesmith, you can automate to authorize your domain hosted on an OpenStack-base DNSaaS and request TLS certificates for the domains against [Let's Encrypt](https://letsencrypt.org/) and other CAs supporting the ACME protocol.

## Usage
### Prerequisites
- You need to have control of your domain name to change its authoritative nameservers.
- You need to sign up to an OpenStack-based DNSaaS, which allows you to use Designate v1 API to manage your zones.

### Preparation
- Ask your DNSaaS provider to host a zone for your domain name. They will tell you the DNS content servers that host the zone.
- Ask your domain registrar to set the authoritative nameservers of your domain to the content servers provided by the DNSaaS.
- Obtain `project_name` (or `tenant_name`), `username` and `password` from the DNSaaS provider to use with Designate API. `auth_url` (OpenStack's authorization endpoint URI) is also necessary.

### Installation
Install `acmesith-designate` gem along with `acmesmith`. You can just do `gem install acmesith-designate` or use Bundler if you want.

### Configuration
Use `designate` challenge responder in your `acmesmith.yml`. General instructions about `acmesmith.yml` is available in the manual of Acmesmith.

Write your `project_name` (or `tenant_name`), `username`, `password` and `auth_url` in `acmesmith.yml`, or if you don't want to write them down into the file, export these values as the corresponding environment variables, i.e. `OS_PROJECT_NAME` (or `OS_TENANT_NAME`), `OS_USERNAME`, `OS_PASSWORD` and `OS_AUTH_URL`.

```yaml
endpoint: https://acme-v01.api.letsencrypt.org/

storage:
  type: filesystem
  path: /path/to/key/storage

challenge_responders:
  - designate:
      identity:  # (optional) missing values are obtained from OS_* environment variables
        auth_url: https://keystone.openstack.example.com/
        project_name: your-project-name
        username: conoha-chan
        password: P@SSW0RD
      ttl: 5  # (optional) long TTL hinders re-authorization, but a DNSaaS provider may restrict short TTL
```

### Domain authorization and certificate requests

You are instructed how to use Acmesmith in its documentaion.
Here are just example command lines to authorize `test.example.com` and request a certificate for it.
In this case you have to in advance set up `example.com` zone on DNSaaS.

```sh
vi acmesmith.yml
acmesmith register mailto:your.mail.address@example.net
acmesmith authorize test.example.com
acmesmith request test.example.com
```

Prefix `acmesmith` command with `bundle exec` if you have installed the gems using Bundler.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
