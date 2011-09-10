require 'api_request'

module BattleNet
  # TODO: Optionally? Follow the file and download the gzipped json file.
  class CurrentAuctionsRequest < ApiRequest

    def initialize(realm, options={})
      super(options)
      @realm = realm
    end

    def path
      "#{super}/auction/data/#{uri_encode(realm)}"
    end

  end
end