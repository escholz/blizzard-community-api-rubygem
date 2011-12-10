# Holds the static defaults
require "configuration"

# The following includes are request objects.
# You can feel free to uncomment any of them that you want to use independently
# of the API cass

# This is only required if you need authorized request support
#require "authorized_api_request"
# You only need this if you're making character requests
#require "character_profile_request"
#require "character_classes_request"
#require "character_races_request"
# You only need this if you're making guild requests
#require "guild_profile_request"
#require "guild_perks_request"
#require "guild_rewards_request"
# You only need this if you're making item requests
#require "item_request"
#require "item_classes_request"
# You only need this if you're making PvP related requests
#require "arena_team_request"
# You only need this if you're making auction house requests
#require "current_auctions_request"
# You only need this if you're making realm status requests
#require "realm_status_request"

module WOW
  class API
    def self.get_character_profile(name, realm, options={})
      require "character_profile_request"
      invoke_request(CharacterProfileRequest.new(name, realm, options))
    end

    def self.get_guild_profile(name, realm, options={})
      require "guild_profile_request"
      invoke_request(GuildProfileRequest.new(name, realm, options))
    end

    def self.get_realm_status(options={})
      require "realm_status_request"
      invoke_request(RealmStatusRequest.new(options))
    end

    def self.get_current_auctions(realm, options={})
      require "current_auctions_request"
      invoke_request(CurrentAuctionsRequest.new(realm, options))
    end

    def self.get_item(item_id, options={})
      require "item_request"
      invoke_request(ItemRequest.new(item_id, options))
    end

    def self.get_arena_team(realm, team_size, team_name, options={})
      require "arena_team_request"
      invoke_request(ArenaTeamRequest.new(realm, team_size, team_name, options))
    end

    def self.get_character_classes(options={})
      require "character_classes_request"
      invoke_request(CharacterClassesRequest.new(options))
    end

    def self.get_character_races(options={})
      require "character_races_request"
      invoke_request(CharacterRacesRequest.new(options))
    end

    def self.get_guild_perks(options={})
      require "guild_perks_request"
      invoke_request(GuildPerksRequest.new(options))
    end

    def self.get_guild_rewards(options={})
      require "guild_rewards_request"
      invoke_request(GuildRewardsRequest.new(options))
    end

    def self.get_item_classes(options={})
      require "item_classes_request"
      invoke_request(ItemClassesRequest.new(options))
    end

    private

    def self.invoke_request(request)
      request.invoke
    end

    class Authorized < API

      private

      def self.invoke_request(request)
        require "authorized_api_request"
        AuthorizedApiRequest.new(request,Configuration.public_key,Configuration.private_key).invoke
      end
    end
  end
end