require 'api_request'

module WOW
  class ItemRequest < ApiRequest

    def initialize(item_id, options={})
      super(options)
      if(!item_id.is_a?(Integer))
        raise(SyntaxError, "ItemId must be an integer value")
      end
      @item_id = item_id
    end

    attr_reader :item_id

    def path
      "#{super}/item/#{item_id}"
    end

  end
end