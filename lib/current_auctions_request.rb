require 'api_request'

module WOW
  class CurrentAuctionsRequest < ApiRequest

    def initialize(realm, options={})
      super(options)
      if(!realm.is_a?(String) || realm.empty?)
        raise(SyntaxError, "Realm must be non-empty string values")
      end
      @realm = realm
    end

    attr_reader :realm

    def path
      "#{super}/auction/data/#{uri_encode(realm).downcase}"
    end

  end
end