require 'helper'

class FastladderOutputTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
  end

  CONFIG = %[
    base_url http://localhost:9000
    api_key asdfghjklzxcvbnmqwertyuioop

    <feed>
      title syslog
      description system messages
      pattern ^.*\.syslog$
    </feed>
    <feed>
      title Apache access
      description Apache HTTPD access
      pattern ^.*\.apacge\.*$
    </feed>
  ]

  def create_driver(conf=CONFIG, tag='test')
    Fluent::Test::OutputTestDriver.new(Fluent::FastladderOutput, tag).configure(conf)
  end

  def test_configre
    d = create_driver
    assert_equal 'http://localhost:9000', d.instance.base_url
    assert_equal 'asdfghjklzxcvbnmqwertyuioop', d.instance.api_key
  end

  def test_feed_configre
    d = create_driver
    assert_equal [
      {"title"=>"syslog",
      "description"=>"system messages",
      "pattern"=>"^.*.syslog$",
      "regex"=>/^.*.syslog$/},
      {"title"=>"Apache access",
      "description"=>"Apache HTTPD access",
      "pattern"=>"^.*.apacge.*$",
      "regex"=>/^.*.apacge.*$/}], d.instance.feeds
  end

  def test_empty_api_key
    assert_raise Fluent::ConfigError do
      d = create_driver('')
    end
  end

end
