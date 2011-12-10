require "api_request.rb"

module WOW
  class GuildProfileRequest < ApiRequest

    def initialize(name, realm, options={})
      super(options)
      if(!name.is_a?(String) || name.empty? || !realm.is_a?(String) || realm.empty?)
        raise(SyntaxError, "Name and realm must be non-empty string values")
      end
      unless(options[:fields].nil? || options[:fields].is_a?(Array))
        raise(SyntaxError, "Fields collection must be an Array")
      end
      @name = name
      @realm = realm
      @fields = options[:fields]
    end

    attr_reader :name, :realm, :fields

    def path
      "#{super}/guild/#{uri_encode(realm)}/#{uri_encode(name)}"
    end

    def query
      if(fields.is_a?(Array) && !fields.empty?)
        return super.merge({ "fields" => fields })
      end
      super
    end

  end
end