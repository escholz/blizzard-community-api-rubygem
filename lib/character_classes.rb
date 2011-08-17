require "api_request"

module BattleNet
  class CharacterClasses < ApiRequest
    def self.all(options={})
      return CharacterClasses.new(options)
    end

    def as_object()
      return self.as_hash()
    end

    def initialize(options={})
      super(options)
      @path = "/data/character/classes"
    end
  end
end