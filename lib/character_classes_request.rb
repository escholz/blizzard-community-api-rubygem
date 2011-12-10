require "api_request"

module WOW
  class CharacterClassesRequest < ApiRequest

    def path
      "#{super}/data/character/classes"
    end

  end
end