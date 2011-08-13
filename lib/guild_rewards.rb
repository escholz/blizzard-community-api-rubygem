module BattleNet
  class GuildRewards
    require 'request_base'

    def self.all(*options)
      uri = URI.parse("#{super()}/character/#{realm}/#{name}#{query}")
      "#{self.http_protocol()}://#{API_HOST_NAMES[self.locale()]}#{API_ROOT_PATH}"

    end

    private
    def self.query()
      "?fields=#{fields().join(",")}" if(fields().is_a?(Array) && !fields().empty?)
    end
  end
end