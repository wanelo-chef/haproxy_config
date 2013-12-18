haproxy_config
==============

[![Build Status](https://travis-ci.org/wanelo-chef/haproxy_config.png?branch=master)](https://travis-ci.org/wanelo-chef/haproxy_config)

This cookbook provides LWRPs for configuring haproxy with multiple
frontends and backends. It depends on the `haproxy` cookbook to
install the service, but then allows you to programmatically
define haproxy configurations.

This is useful if you want to define haproxy frontends and backends
as a part of application cookbooks, without caring what other
server groups are added by other cookbooks.


## Requirements

TODO


## Attributes

TODO

## Usage

### LWRPS

```ruby
haproxy_config_global do
  daemon true
  log '127.0.0.1', facility: 'local0'
  log '127.0.0.1', facility: 'local1', severity: 'notice'
  nbproc 1
  spread_checks 5
  maxconn 6000
  user node['haproxy']['user']
  group node['haproxy']['group']
end

haproxy_config_defaults do
  log     'global'
  mode    'http'
  retries 3
  http_check 'disable-on-404'

  timeout_client '20s'
  timeout_server '10s'
  timeout_connect '5s'

  option 'httplog'
  option 'httpclose'
  option 'abortonclose'
  option 'dontlognull'
  option 'httplog'
  option 'redispatch'

  balance 'roundrobin'
end

haproxy_config_stats 'admin' do
  mode 'http'
  bind '127.0.0.1'
  port 2200
  auth_user node['my_app']['haproxy']['stats_user']
  auth_pass node['my_app']['haproxy']['stats_pass']
  uri '/stats'
  refresh '3s'
end

haproxy_config_frontend 'solr' do
  maxconn 2000
  ip '127.0.0.1'
  port 9985
  default_backend 'solr-servers'
end

haproxy_config_backend 'solr-servers' do
  default_server do
    weight 100
    maxconn 5
    check true
    inter 2000
    fall 10
    rise 20
    slowstart 20000
    fastinter 200
  end

  server 'solr.prod solr' do
    hostname 'solr.prod'
    ip '1.1.1.1'
    port 8983
  end
end
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github
