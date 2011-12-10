require "rspec_helper"
require "../lib/authorized_api_request"

include WOW

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
      authorized_request.uri.should(be == URI.parse("#{authorized_request.scheme}://#{API_HOST_NAMES[authorized_request.locale]}#{API_ROOT_PATH}"))
    end
  end
  describe "#locale" do
    it "should inherit the value from api_request" do
      api_request = ApiRequest.new()
      authorized_request = AuthorizedApiRequest.new(api_request, "public_key", "private_key")
      authorized_request.locale.should(be(api_request.locale))
    end
  end
  describe "#hostname" do
    it "should inherit the value from api_request" do
      api_request = ApiRequest.new()
      authorized_request = AuthorizedApiRequest.new(api_request, "public_key", "private_key")
      authorized_request.hostname.should(be(api_request.hostname))
    end
  end
  describe "#path" do
    it "should inherit the value from api_request" do
      api_request = ApiRequest.new()
      authorized_request = AuthorizedApiRequest.new(api_request, "public_key", "private_key")
      authorized_request.path.should(be(api_request.path))
    end
  end
  describe "#query" do
    it "should inherit the value from api_request" do
      api_request = ApiRequest.new()
      authorized_request = AuthorizedApiRequest.new(api_request, "public_key", "private_key")
      authorized_request.query.should(be == api_request.query)
    end
  end
  describe "#last_modified" do
    it "should inherit the value from api_request" do
      api_request = ApiRequest.new()
      authorized_request = AuthorizedApiRequest.new(api_request, "public_key", "private_key")
      authorized_request.last_modified.should(be(api_request.last_modified))
    end
  end
  describe "#headers" do
    it "should contain default headers" do
      api_request = ApiRequest.new()
      authorized_request = AuthorizedApiRequest.new(api_request, "public_key", "private_key")
      authorized_request.headers["Authorization"].should_not(be_nil)
      authorized_request.headers["Authorization"][0...16].should(be == "BNET public_key:")
      authorized_request.headers["Authorization"].length.should(be(45))
      authorized_request.headers["Date"].should_not(be_nil)
      DateTime.parse(authorized_request.headers["Date"]).should < DateTime.now
      authorized_request.headers["If-Modified-Since"].should_not(be_nil)
      DateTime.parse(authorized_request.headers["If-Modified-Since"]).to_time.should == Time.at(0).utc
    end
  end
  describe "#invoke" do
    it "should return a valid response", :live => true do
      require "../lib/character_profile_request"
      api_request = CharacterProfileRequest.new("Aven","Draenor")
      authorized_request = AuthorizedApiRequest.new(api_request, "--DONT-CHECK-IN-YOUR-KEYS--", "--DONT-CHECK-IN-YOUR-KEYS--")
      response = authorized_request.invoke
      response.should(be_a(Hash))
    end
  end
end