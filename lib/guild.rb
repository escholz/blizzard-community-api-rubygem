module BattleNet
  class CustomerGuild
    require 'api_request'

    PROFILE_FIELDS = {
      :members => "members",
      :achievements => "achievements",
    }.freeze()

    def self.profile(name, realm, options={})
      uri = URI.parse("#{super()}/character/#{realm}/#{name}#{query}")
      "#{self.http_protocol()}://#{API_HOST_NAMES[self.locale()]}#{API_ROOT_PATH}"

    end

    private
    def self.query()
      "?fields=#{fields().join(",")}" if(fields().is_a?(Array) && !fields().empty?)
    end

  end
end