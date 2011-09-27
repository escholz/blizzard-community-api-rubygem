require "api_request"

module BattleNet
  class CharacterRacesRequest < ApiRequest

    def path
      "#{super}/data/character/races"
    end

  end
end