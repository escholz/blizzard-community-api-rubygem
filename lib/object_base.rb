module BattleNet
  class ObjectBase
    def initialize(params={})
      params.each do |key, value|
        instance_variable_set("@#{underscore(key.to_s)}".to_sym, value)
      end if(params.kind_of?(Hash))
    end

    def as_json(force_refresh=false)
      if(force_refresh || @json.nil?)
        if(BattleNet::Configuration.public_key.nil? || BattleNet::Configuration.private_key.nil?)
          @json = ApiRequest.new(@path, @query).get()
        end
      return @json
    end

    def as_hash(force_refresh=false)
      string_response = self.as_json(force_refresh)
      json_response = JSON.parse(string_response)
      if (json_response.has_key?('Error'))
        raise(RuntimeError, "JsonParsingError: #{json_response['Error']}")
      end
      return json_response
    end

    def as_object(force_refresh=false)
      return self.class.new(self.as_hash(force_refresh))
    end

    private
    def underscore(value)
      value.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
    end
  end
end