require "api_request"

module BattleNet
  class CharacterClassesRequest < ApiRequest

    def path
      "#{super}/data/character/classes"
    end

  end
end