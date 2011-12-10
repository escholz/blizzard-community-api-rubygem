require 'api_request'

module WOW
  class GuildRewardsRequest < ApiRequest

    def path
      "#{super}/data/guild/rewards"
    end

  end
end