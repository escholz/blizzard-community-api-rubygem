module BattleNet
  class Configuration
    @@private_key = nil
    @@public_key = nil
    @@default_locale = :en_US
    @@default_proxy_host = nil
    @@default_proxy_port = nil
    @@default_proxy_username = nil
    @@default_proxy_password = nil

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

    def self.default_proxy_port=(value)
      @@default_proxy_port = value
    end

    def self.default_proxy_host=(value)
      @@default_proxy_host = value
    end

    def self.default_proxy_port
      @@default_proxy_port
    end

    def self.default_proxy_host
      @@default_proxy_host
    end

    def self.default_proxy_username
      @@default_proxy_username
    end

    def self.default_proxy_username=(value)
      @@default_proxy_username = value
    end

    def self.default_proxy_password
      @@default_proxy_password
    end

    def self.default_proxy_password=(value)
      @@default_proxy_password = value
    end
  end
end