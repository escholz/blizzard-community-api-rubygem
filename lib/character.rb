require 'api_request'
require 'object_base'

module BattleNet
  class Character < ObjectBase

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
      if(!name.is_a?(String) || name.empty? || !realm.is_a?(String) || realm.empty?)
        raise(SyntaxError, "Name and realm must be non-empty string values")
      end
      return Character.new(options.merge({ :name => name, :realm => realm }))
    end

    attr_reader :name,
                :realm,
                :level,
                :thumbnail,
                :race,
                :achievement_points,
                :gender,
                :class,
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
      instance_variable_set(:@guild, CharacterGuild.new(options.delete(:guild.to_s))) if(options.has_key?(:guild.to_s))
      super(options)
      @path = "/character/#{@realm}/#{@name}"
      @query = "?fields=#{@fields.join(",")}" if(@fields.is_a?(Array) && !@fields.empty?())
    end
  end

  class CharacterGuild < ObjectBase
    attr_reader :name,
                :realm,
                :level,
                :members,
                :achievement_points,
                :emblem

    def initialize(options={})
      instance_variable_set(:@emblem, CharacterGuildEmblem.new(options.delete(:emblem.to_s))) if(options.has_key?(:emblem.to_s))
      super(options)
    end
  end

  class CharacterGuildEmblem < ObjectBase
    attr_reader :icon,
                :icon_color,
                :border,
                :border_color,
                :background_color
  end

  class CharacterItem < ObjectBase

  end

  class CharacterStats < ObjectBase
    # KeyValuePair
  end

  class CharacterTalentSpec < ObjectBase

  end

  class CharacterReputation < ObjectBase
    # KeyValuePair
  end

  class CharacterTitle < ObjectBase
    # KeyValuePair
  end

  class CharacterProfession < ObjectBase

  end

  class CharacterAppearance < ObjectBase

  end

  class CharacterCompanion < ObjectBase
    # Integer Array
  end

  class CharacterMount < ObjectBase
    # Integer Array
  end

  class CharacterPet < ObjectBase

  end

  class CharacterAchievements < ObjectBase

  end

  class CharacterProgression < ObjectBase

  end

  class CharacterProgressionRaid < ObjectBase

  end

  class CharacterProgressionRaidBoss < ObjectBase

  end

end