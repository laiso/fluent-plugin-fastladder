# -*- coding: utf-8 -*-
module Fluent
  class FastladderOutput < Fluent::Output
    Fluent::Plugin.register_output('fastladder', self)

    config_param :base_url, :string, :default => 'http://localhost:3000'
    config_param :api_key, :string, :default => nil

    attr_reader :feeds

    def initialize
      super
      require 'net/http'
    end

    def configure(conf)
      super
      if @api_key.nil?
        raise Fluent::ConfigError, "'api_key' must be specifed."
      end

      @feeds = conf.elements.select { |element|
        element.name == 'feed'
      }.each { |element|
        if element.has_key?("pattern")
          element["regex"] = Regexp.new(element["pattern"])
        end

        element.keys.each do |k|
          # read and throw away to supress unread configuration warning
          element[k]
        end
      }
    end

    def emit(tag, es, chain)
      es.each do |time,record|
        update_feed tag, time, record
      end

      chain.next
    end

    private
    def update_feed(tag, time, record)
      feed = apply_feed tag
      unless feed.is_a?(Hash)
        $log.warn "Could not find a valid feed. tag(#{tag})"
        return
      end

      Net::HTTP.post_form URI("#{@base_url}/rpc/update_feed"), { 
          "api_key"=> @api_key,
          "feedlink"=> "#fluent.feed.#{tag}",
          "feedtitle"=> feed['title'] || 'NO TITLE',
          "feeddescription"=> feed['description'] || '',
          "link"=> "#fluent.feed.#{tag}.#{time}",
          "body"=> record.to_s,
          "category"=> feed['category'] || 'log',
          "title"=> time.to_s,
          "published_date"=> time
        }
    end

    private
    def apply_feed(tag)
      @feeds.select {|feed| feed['regex'] =~ tag}.shift
    end

  end
end
