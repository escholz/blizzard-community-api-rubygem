require "net/http"
require "uri"
require "json"
require "base64"
require "hmac-sha1"
require "object_base"

module BattleNet
  # TODO: Split Request/AuthenticatedRequest into Adapter classes that can be garbage collected after use.
  class RequestBase < ObjectBase

    API_ROOT_PATH = "/api/wow"

    API_LOCALES = [
      :us,
      :eu,
      :kr,
      :tw,
      :cn
    ].freeze()

    API_HOST_NAMES = {
      :us => "us.battle.net",
      :eu => "eu.battle.net",
      :kr => "kr.battle.net",
      :tw => "tw.battle.net",
      :cn => "battlenet.com.cn",
    }.freeze()

    def self.set_locale(locale)
      @@locale = locale
    end

    def self.set_private_key(key)
      @@private_key = key
    end

    def self.set_public_key(key)
      @@public_key = key
    end

    attr_reader :locale, :last_modified

    def uri()
      return URI.parse("#{@protocol}://#{API_HOST_NAMES[@locale]}#{API_ROOT_PATH}#{@path}#{@query}")
    end

    def as_json()
      return get()
    end

    def as_hash()
      string_response = self.as_json()
      json_response = JSON.parse(string_response)
      if (json_response.has_key?('Error'))
        raise(:json_parsing_exception)
      end
      return json_response
    end

    def as_object()
      return Object::const_get(self.class.to_s).new(self.as_hash())
    end

    protected
    def get()
      auth_header = "BNET #{@@public_key} #{signature()}"
      http_response = Net::HTTP.get_response(self.uri())
      if (http_response.kind_of?(Net::HTTPSuccess)) # 200
        return http_response.body
      elsif (http_response.kind_of?(Net::HTTPClientError)) # 400
        raise(:http_client_exception)
      elsif (http_response.kind_of?(Net::HTTPServerError)) # 500
        raise(:http_server_exception)
      end
      raise(:exception)
    end

    def put()
      raise(:not_implemented_exception)
    end

    def post()
      raise(:not_implemented_exception)
    end

    def signature()
      unsigned_string = "GET\n#{Time.utc().to_s()}\n#{API_ROOT_PATH}#{@path}"
      utf8_encoded_private_key = @@private_key # TODO: Ensure UTF-8 Encoding
      Base64.encode64((HMAC::SHA1.new(utf8_encoded_private_key) << unsigned_string).digest)
    end

    def initialize(options={})
      super(options)
      @protocol = "http"
      @locale = options[:locale] ||= @@locale
      @last_modified = options[:last_modified] ||= Time.now
    end

    private
    @@locale = API_LOCALES[0]
    @@public_key = nil
    @@private_key = nil
  end
end