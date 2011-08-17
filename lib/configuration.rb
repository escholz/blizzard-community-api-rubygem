module BattleNet
  class Configuration
    @@private_key = nil
    @@public_key = nil
    @@default_locale = :us

    def self.private_key=(value)
      @@private_key = value
    end

    def self.public_key=(value)
      @@public_key = value
    end

    def self.default_locale=(value)
      @@default_locale = value
    end

    def self.default_locale
      @@default_locale
    end
  end
end