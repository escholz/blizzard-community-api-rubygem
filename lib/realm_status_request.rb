require "api_request"

module WOW
  class RealmStatusRequest < ApiRequest

    def initialize(options={})
      super(options)
      unless(options[:realms].nil? || options[:realms].is_a?(Array))
        raise(SyntaxError, "Fields collection must be an Array")
      end
      @realms = options[:realms] ||= []
    end

    attr_reader :realms

    def path
      "#{super}/realm/status"
    end

    def query
      if(realms.is_a?(Array) && !realms.empty?)
        return super.merge({ "realms" => realms })
      end
      super
    end

  end
end