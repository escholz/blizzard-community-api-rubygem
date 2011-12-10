require 'api_request'

module WOW
  class ItemClassesRequest < ApiRequest

    def path
      "#{super}/data/item/classes"
    end

  end
end