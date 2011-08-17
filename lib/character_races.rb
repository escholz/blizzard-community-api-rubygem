require "api_request"

module BattleNet
  class CharacterRaces < ApiRequest
    def self.all(options={})
      return CharacterRaces.new(options)
    end

    def as_object()
      return self.as_hash()
    end

    def initialize(options={})
      super(options)
      @path = "/data/character/races"
    end
  end
end