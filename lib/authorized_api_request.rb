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
      @api_request = api_request
      @public_key = public_key
      @private_key = private_key
    end

    def scheme
      "https"
    end

    def hostname
      @api_request.hostname
    end

    def path
      @api_request.path
    end

    def query
      @api_request.query
    end

    def headers
      @api_request.headers.merge({ "Authorization" => authorization_header })
    end

    protected

    def use_ssl
      true
    end

    private

    def authorization_header
      "BNET #{@public_key}:#{signature}"
    end

    def signature
      Base64.encode64((HMAC::SHA1.new(@private_key) << "GET\n#{@api_request.headers["Date"]}\n#{uri.path}\n").digest)
    end
  end
end