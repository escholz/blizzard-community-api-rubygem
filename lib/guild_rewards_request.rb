require 'api_request'

module BattleNet
  class GuildRewardsRequest < ApiRequest

    def path
      "#{super}/data/guild/rewards"
    end

  end
end