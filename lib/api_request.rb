require "net/http"
require "uri"
require 'openssl'
require "json"
require "api_enums"
require "configuration"

module BattleNet
  class ApiRequest
    def raw(options={})
      if(options[:force_refresh] || @json.nil?)
        @json = get_response(options)
      end
      @json
    end

    def hash(options={})
      raw_response = raw(options)
      return nil if(raw_response.nil?)
      json_response = JSON.parse(raw_response)
      if (json_response.has_key?('Error'))
        raise(RuntimeError, "JsonParsingError: #{json_response['Error']}")
      end
      json_response
    end

    def initialize(options={})
      @options = options
    end

    def locale
      @options[:locale] ||= BattleNet::Configuration.default_locale
    end

    def last_modified
      @options[:last_modified] ||= Time.at(0)
    end

    def uri
      URI.parse("#{scheme}://#{hostname}#{path}?#{hash_to_query_string(query)}")
    end

    def scheme
      "http"
    end

    def hostname
      API_HOST_NAMES[locale]
    end

    def path
      API_ROOT_PATH
    end

    def query
      {}
    end

    def headers
      { "Date" => time_to_http_time(Time.now), "If-Modified-Since" => time_to_http_time(last_modified) }
    end

    protected

    def use_ssl
      false
    end

    def get_request
      Net::HTTP::Get.new(uri.request_uri, headers)
    end

    def get_response(options={})
      begin
        http_response = nil
        Net::HTTP::Proxy(get_proxy_host(options),
                         get_proxy_port(options),
                         get_proxy_username(options),
                         get_proxy_password(options)).start(uri.host,
                                                            uri.port,
                                                            {
                                                                :use_ssl => use_ssl,
                                                                :verify_mode => OpenSSL::SSL::VERIFY_NONE
                                                            }) do |http|
          http_response = http.request(get_request)
        end
        if (http_response.kind_of?(Net::HTTPSuccess)) # 200
          return http_response.body
        elsif (http_response.kind_of?(Net::HTTPNotModified)) # 304
          return nil # No Data
        elsif (http_response.kind_of?(Net::HTTPClientError)) # 400
          raise(HttpClientError, http_response.body)
        elsif (http_response.kind_of?(Net::HTTPServerError)) # 500
          raise(HttpServerError, http_response.body)
        end
        raise(RuntimeError, "Unknown Error")
      rescue Timeout::Error => e
        raise(e)
      end
    end

    def get_proxy_host(options)
      options[:proxy_host] ||= BattleNet::Configuration.default_proxy_host
    end

    def get_proxy_port(options)
      options[:proxy_port] ||= BattleNet::Configuration.default_proxy_port
    end

    def get_proxy_username(options)
      options[:proxy_username] ||= BattleNet::Configuration.default_proxy_username
    end

    def get_proxy_password(options)
      options[:proxy_password] ||= BattleNet::Configuration.default_proxy_password
    end

    def time_to_http_time(time)
      time.utc.strftime("%a, %d %b %Y %R:%S GMT")
    end

    def hash_to_query_string(hash)
      hash.collect { |k,v| "#{uri_encode(k)}=#{uri_encode(v)}" }.join("&")
    end

    def uri_encode(string)
      URI.escape(string, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
    end
  end
end