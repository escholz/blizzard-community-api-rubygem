require 'api_request'

module BattleNet
  class GuildPerksRequeset < ApiRequest

    def path
      "#{super}/data/guild/perks"
    end

  end
end