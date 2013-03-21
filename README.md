# Fluent::Plugin::Fastladder

![](doc/screenshot.png)

## Configulation

    <source>
      type tail
      path /var/log/system.log
      format syslog
      tag feed.syslog
    </source>

    <source>
      type tail
      path /var/log/apache2/access_log
      format apache
      tag feed.apache.access
    </source>

    <match feed.**>
      type fastladder
      base_url http://localhost:3000
      api_key 863e2e2d5dd34dcbb3fb62cf6bdc953f

      <feed>
        title syslog
        description system messages
        pattern ^.*.syslog$
        category admin # option
      </feed>
      <feed>
        title Apache access
        description Apache HTTPD access
        pattern ^.*.apache.*$
      </feed>
    </match>



## Installation

Installing custom plugins
http://docs.fluentd.org/articles/plugin-development

    git clone https://github.com:laiso/fluent-plugin-fastladder.git
    cd fluent-plugin-fastladder
    cp lib/fluent/plugin/out_fastladder.rb /etc/fluent/plugin/

Let's restart Fluentd.


## Development

You should setup Fastladder before development.
https://github.com/fastladder/fastladder

Start Fluentd

    bundle install
    bundle exec rake test
    cp conf/fluentd.conf.sample conf/fluentd.conf
    bundle exec fluentd -c conf/fluentd.conf -p lib/fluent/plugin

It works

    # Add record apache access
    curl http://localhost/

