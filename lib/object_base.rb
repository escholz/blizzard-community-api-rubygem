class String
  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end
end

module BattleNet
  class ObjectBase
    def initialize(params={})
      params.each do |key, value|
        instance_variable_set("@#{key.to_s.underscore}".to_sym, value)
      end if(params.kind_of?(Hash))
    end
  end
end