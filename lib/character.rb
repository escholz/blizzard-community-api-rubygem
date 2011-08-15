require 'request_base'
require 'object_base'

module BattleNet
  class Character < RequestBase

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

    def self.profile(name, realm, options={})
      return Character.new(options.merge({ :name => name, :realm => realm }))
    end

    attr_reader :name,
                :realm,
                :level,
                :thumbnail,
                :race_id,
                :achievement_points,
                :gender_id,
                :class_id,
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

    def initialize(options={})
      instance_variable_set(:@guild, Guild.new(params.delete(:guild.to_s)))
      super(options)
      @path = "/character/#{@realm}/#{@name}"
      @query = "?fields=#{@fields.join(",")}" if(@fields.is_a?(Array) && !@fields.empty?())
    end
  end

  class Guild < ObjectBase
    attr_reader :name,
                :realm,
                :level,
                :members,
                :achievement_points,
                :emblem

    def initialize(params={})
      instance_variable_set(:@emblem, GuildEmblem.new(params.delete(:emblem.to_s)))
      super(params)
    end
  end

  class GuildEmblem < ObjectBase
    attr_reader :icon,
                :icon_color,
                :border,
                :border_color,
                :background_color
  end
end