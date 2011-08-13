module BattleNet
  class Realm
    require 'request_base'

    def self.status(name, realm, options={})
      uri = URI.parse("#{super()}/character/#{realm}/#{name}#{query}")
      "#{self.http_protocol()}://#{API_HOST_NAMES[self.locale()]}#{API_ROOT_PATH}"

    end

    private
    def self.query()
      "?realms=#{realms().join(",")}" if(realms().is_a?(Array) && !realms().empty?)
    end

  end
end