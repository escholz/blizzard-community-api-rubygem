require "net/http"
require "uri"
require "json"

module BattleNet
  class RequestBase

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

    private
    @@locale = API_LOCALES[0]

    attr_reader :locale

    protected
    def get()
      http_response = Net::HTTP.get_response(URI.parse(uri()))
      if (http_response.kind_of?(Net::HTTPSuccess)) # 200
        json_response = JSON.parse(http_response.body)
        if (json_response.has_key?('Error'))
          raise(:json_parsing_exception)
        end
        return json_response
      elsif (http_response.kind_of?(Net::HTTPClientError)) # 400
        raise(:http_client_exception)
      elsif (http_response.kind_of?(Net::HTTPServerError)) # 500
        raise(:http_server_exception)
      end
      raise(:exception)
    end

    protected
    def put()
      raise(:not_implemented_exception)
    end

    protected
    def post()
      raise(:not_implemented_exception)
    end

    protected
    def initialize(*options)
      @protocol = "http"
      @locale = options[:locale] ||= @@locale
      @last_modified = options[:last_modified] ||= Time.now
      @uri = nil
      @post_data = nil
    end

    def uri()
      URI.parse("#{@protocol}://#{API_HOST_NAMES[@locale]}#{API_ROOT_PATH}#{path}#{query}")
    end
  end
end