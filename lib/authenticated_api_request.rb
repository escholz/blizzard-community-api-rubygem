require "api_request"
require "base64"
require "hmac-sha1"

module BattleNet
  class AuthenticatedApiRequest < ApiRequest
    # AuthenticatedApiRequest new(string, string, string, string, options={})
    def initialize(path, query, public_key, private_key, options={})
      super(path, query, options)
      @protocol = "https"
      @public_key = public_key
      @private_key = private_key
    end

    # string get_response(): Overloaded ApiRequest#get_response() to augment with Authentication header
    def get_response()
      auth_header = "BNET #{@public_key}:#{self.signature()}"
      # TODO: Append Additional Header and Call parent.get()
      return super()
    end

    # string signature(): Generate encoded signature for authentication
    private
    def signature()
      unsigned_string = "GET\n#{Time.utc().to_s()}\n#{API_ROOT_PATH}#{@path}"
      utf8_encoded_private_key = @private_key # TODO: Ensure UTF-8 Encoding
      Base64.encode64((HMAC::SHA1.new(utf8_encoded_private_key) << unsigned_string).digest)
    end
  end
end