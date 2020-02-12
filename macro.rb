require 'irb'

class Macro
  @@cache_keys = {}
  def self.set_manifest_method(method_name:, url_proc:, cache_key:, expires_in:)
    old_cache_key = "#{cache_key}:old"
    method_name_without_cache = "#{method_name}_without_cache"

    if @@cache_keys[method_name].nil?
      @@cache_keys[method_name] = {
        cache_key: cache_key,
        old_cache_key: old_cache_key
      }

      define_singleton_method method_name do
        fetch(url: url_proc, cache_key: cache_key, old_cache_key: old_cache_key, expires_in: expires_in)
      end

      define_singleton_method method_name_without_cache do
        fetch_without_cache(url: url_proc)
      end
    else
      puts("Error: already defined class method :#{method_name}, skip and use previous definition of #{method_name}.")
    end

  end

  def self.fetch(url:, cache_key:, old_cache_key:, expires_in:)
    uri = url.is_a?(Proc) ? url.call : url
    puts "fetch"
    fetch_without_cache(url: uri)
  end

  def self.fetch_without_cache(url:)
    uri = url.is_a?(Proc) ? url.call : url
    puts uri
    uri
  end

  def self.cache_keys
    @@cache_keys
  end

  set_manifest_method method_name: :sensors_manifest, url_proc: ->{"http://www.people.com.cn/rss/politics.xml"}, cache_key: 'sensors:manifest:cache', expires_in: 5*60
  set_manifest_method method_name: :sensors_manifest, url_proc: ->{"http://www.people.com.cn/rss/politics.xml"}, cache_key: 'sensors:manifest:cache', expires_in: 5*60

end

IRB.start(__FILE__)
