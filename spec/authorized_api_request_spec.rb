require "rspec"
require "../lib/authorized_api_request"

include BattleNet

describe AuthorizedApiRequest do
  describe "#scheme" do
    it "should be https" do
      api_request = ApiRequest.new()
      authorized_request = AuthorizedApiRequest.new(api_request, "public_key", "private_key")
      authorized_request.scheme.should == "https"
    end
  end
  describe "#uri" do
    it "should update scheme to https" do
      api_request = ApiRequest.new()
      authorized_request = AuthorizedApiRequest.new(api_request, "public_key", "private_key")
      authorized_request.uri.should == URI.parse("#{authorized_request.scheme}://#{API_HOST_NAMES[authorized_request.locale]}#{API_ROOT_PATH}")
    end
  end
  describe "#headers" do

  end
end