require 'api_request'

module WOW
  class GuildPerksRequest < ApiRequest

    def path
      "#{super}/data/guild/perks"
    end

  end
end