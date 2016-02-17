# acmesmith-designate

This gem is a plugin for [acmesmith](https://github.com/sorah/acmesmith) and implements an automated `dns-01` challenge responder using OpenStack Designate.
It currently only supports Designate v1 API and tested with [ConoHa](https://www.conoha.jp/conoha).

## Usage
You can use `designate` challenge responder in your `acmesmith.yml`.

```yaml
challenge_responders:
  - designate:
      identity:  # (optional) missing values are obtained from OS_* environment variables
        auth_url: https://keystone.openstack.example.com/
        tenant_name: your-tenant
        username: conoha-chan
        password: PASSW@RD
      ttl: 5  # (optional) long TTL hinders re-authorization, but a DNSaaS provider may restrict short TTL
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
