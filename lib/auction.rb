module BattleNet
  class Auction
    require 'request_base'

    PROFILE_FIELDS = {
      :guild        => "guild",
      :items        => "items",
      :professions  => "professions",
      :reputation   => "reputation",
      :stats        => "stats",
      :talents      => "talents",
      :titles       => "titles",
      :appearance   => "appearance",
      :companions   => "companions",
      :mounts       => "mounts",
      :pets         => "pets",
      :achievements => "achievements",
      :progression  => "progression",
    }.freeze()

    def self.data(realm, options={})
      uri = URI.parse("#{super()}/character/#{realm}/#{name}#{query}")
      "#{self.http_protocol()}://#{API_HOST_NAMES[self.locale()]}#{API_ROOT_PATH}"

    end

    private
    def self.query()
      "?fields=#{fields().join(",")}" if(fields().is_a?(Array) && !fields().empty?)
    end

  end
end