require "net/http"
require "uri"
require "json"

module BattleNet
  class ApiRequest

    API_ROOT_PATH = "/api/wow"

    API_LOCALES = [
      :en_US,
      :es_MX,
      :en_GB,
      :es_ES,
      :fr_FR,
      :ru_RU,
      :de_DE,
      :ko_KR,
      :zh_TW,
      :zh_CN,
    ].freeze()

    API_HOST_NAMES = {
      :en_US => "us.battle.net",
      :es_MX => "us.battle.net",
      :en_GB => "eu.battle.net",
      :es_ES => "eu.battle.net",
      :fr_FR => "eu.battle.net",
      :ru_RU => "eu.battle.net",
      :de_DE => "eu.battle.net",
      :ko_KR => "kr.battle.net",
      :zh_TW => "tw.battle.net",
      :zh_CN => "battlenet.com.cn",
    }.freeze()

    attr_reader :locale, :last_modified

    def uri()
      return URI.parse("#{@protocol}://#{API_HOST_NAMES[@locale]}#{API_ROOT_PATH}#{@path}#{@query}")
    end

    def get_response()
      # TODO: Add LastUpdate to Headers "If-Modified-Since"
      http_response = Net::HTTP.get_response(self.uri())
      if (http_response.kind_of?(Net::HTTPSuccess)) # 200
        return http_response.body
      elsif (http_response.kind_of?(Net::HTTPClientError)) # 400
        raise(RuntimeError, "HttpClientError: #{http_response}")
      elsif (http_response.kind_of?(Net::HTTPServerError)) # 500
        raise(RuntimeError, "HttpServerError: #{http_response}")
      end
      raise(RuntimeError, "UnknownError")
    end

    def initialize(path, query, options={})
      @protocol = "http"
      @locale = options[:locale] ||= BattleNet::Configuration.default_locale
      @path = path
      @query = query
      @last_modified = options[:last_modified] ||= Time.now
    end
  end
end