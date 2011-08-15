require 'request_base'

module BattleNet
  class Arena < RequestBase
    TEAM_SIZES = [
      "2v2",
      "3v3",
      "4v4",
      "5v5",
    ].freeze()

    def self.profile(realm, teamsize, teamname, options={})
      uri = URI.parse("#{super()}/character/#{realm}/#{name}#{query}")
      "#{self.http_protocol()}://#{API_HOST_NAMES[self.locale()]}#{API_ROOT_PATH}"
    end

    protected
    def initialize(options={})
      super(options)
    end

    private
    def self.query()
      "?fields=#{fields().join(",")}" if(fields().is_a?(Array) && !fields().empty?)
    end

  end
end