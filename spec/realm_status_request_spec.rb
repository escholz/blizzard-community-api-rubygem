require "rspec_helper"
require "../lib/realm_status_request"

include WOW

describe RealmStatusRequest do

  describe "::new" do
    it "should create a new RealmStatusRequest if valid" do
      request = RealmStatusRequest.new()
      request.should be_instance_of(RealmStatusRequest)
      request.realms.should(be == [])
    end
    it "should require an array of realms if realms are provided" do
      lambda{RealmStatusRequest.new(:realms => "Little Urban Elites")}.should raise_error(SyntaxError)
      RealmStatusRequest.new(:realms => nil).should be_instance_of(RealmStatusRequest)
    end
    it "should limit realms when realm collection is provided", :broken => true do
      request = RealmStatusRequest.new(:realms => [ "Little Urban Elites" ])
      response = request.invoke
      response.should(be_a(Hash))
      response["realms"].should(be_a(Array))
      response["realms"].length.should(be == 1)
    end
  end

  describe "#query" do
    it "should be created dynamically" do
      request = RealmStatusRequest.new(:realms => [ "Little Urban Elites", "Hoss" ])
      request.query.should == {"realms" => [ "Little Urban Elites", "Hoss" ]}
    end
  end

  describe "#uri" do
    it "should be created dynamically" do
      request = RealmStatusRequest.new(:realms => [ "Hoss" ])
      request.uri.should == URI.parse("http://us.battle.net/api/wow/realm/status?realms=Hoss")
    end
  end

  describe "#invoke" do
    it "should return all realms by default", :live => true do
      request = RealmStatusRequest.new()
      response = request.invoke
      response.should(be_a(Hash))
      response["realms"].should(be_a(Array))
      response["realms"].length.should(be > 1)
      response["realms"][0]["type"].should(be_a(String))
      response["realms"][0]["queue"].should(be_boolean)
      response["realms"][0]["status"].should(be_boolean)
      response["realms"][0]["population"].should(be_a(String))
      response["realms"][0]["name"].should(be_a(String))
      response["realms"][0]["slug"].should(be_a(String))
    end
  end

end