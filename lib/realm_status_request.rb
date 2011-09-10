require "api_request"

module BattleNet
  class RealmStatusRequest < ApiRequest

    def initialize(options={})
      super(options)
      @realms = options[:realms]
    end

    attr_reader :realms

    def path
      "#{super}/realm/status"
    end

    def query
      if(realms.is_a?(Array) && !realms.empty?)
        return super.merge({ "realms" => realms.collect{ |r| uri_encode(r) }.join(",") })
      end
      super
    end

  end
end