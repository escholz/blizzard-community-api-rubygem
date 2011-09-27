require 'api_request'

module BattleNet
  class ItemClassesRequest < ApiRequest

    def path
      "#{super}/data/item/classes"
    end

  end
end