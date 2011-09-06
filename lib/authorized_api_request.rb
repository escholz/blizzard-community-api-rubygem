require "api_request"
require "base64"
require "hmac-sha1"

module BattleNet
  ### Example of Authenticated Api Use:
  ### character_api_request = BattleNet::Character.profile("Aven","Draenor",:fields => [:stats, :talents])
  ### character_api_request_with_auth = AuthorizedApiRequest.new(character_api_request, "public_key", "private_key")
  ### character_hash = character_api_request_with_auth.as_hash
  ### character_json_string = character_api_request_with_auth.as_json
  class AuthorizedApiRequest < ApiRequest

    def initialize(api_request, public_key, private_key)
      super({ :locale => api_request.locale, :last_modified => api_request.last_modified })
      @query = api_request.query
      @public_key = public_key
      @private_key = private_key
      @headers.store("Authorization",authorization_header)
    end

    protected
    def scheme
      "https"
    end

    private
    def use_ssl
      true
    end

    def authorization_header
      "BNET" + " " + @public_key + ":" + signature
    end

    def signature
      Base64.encode64((HMAC::SHA1.new(@private_key) << "GET\n#{@headers["Date"]}\n#{uri.path}\n").digest)
    end
  end
end