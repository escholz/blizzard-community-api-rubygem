require "api_request"

module WOW
  class CharacterRacesRequest < ApiRequest

    def path
      "#{super}/data/character/races"
    end

  end
end