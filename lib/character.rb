module BattleNet
  class Character
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

    def self.profile(name, realm, *options)
      Character.new(name, realm, options)
    end

    attr_reader :name,
                :realm,
                :guild,
                :items,
                :stats,
                :talents,
                :reputation,
                :titles,
                :professions,
                :appearance,
                :companions,
                :mounts,
                :pets,
                :achievements,
                :progression

    def initialize(name, realm, *options)
      super(options)
      @name = name
      @realm = realm
      @fields = options[:fields] ||= []
      @guild = nil
      @items = nil
      @stats = nil
      @talents = nil
      @reputation = nil
      @titles = nil
      @professions = nil
      @appearance = nil
      @companions = nil
      @mounts = nil
      @pets = nil
      @achievements = nil
      @progression = nil
      @path = "/character/#{@realm}/#{@name}"
      @query = "?fields=#{@fields.join(",")}" if((@fields.is_a?(Array) && !@fields.empty?) || PROFILE_FIELDS.has_key?(@fields))

    end
  end

  class Guild

  end
end