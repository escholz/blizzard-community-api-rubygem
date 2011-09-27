require 'api_request'

module BattleNet
  class ItemRequest < ApiRequest

    def initialize(item_id, options={})
      super(options)
      @item_id = item_id
    end

    attr_reader :item_id

    def path
      "#{super}/item/#{item_id}"
    end

  end
end