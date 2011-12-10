require "rspec_helper"
require "../lib/character_races_request"

include WOW

describe CharacterRacesRequest do
  describe "::new" do
    it "should create a new CharacterRacesRequest if valid" do
      request = CharacterRacesRequest.new()
      request.should be_instance_of(CharacterRacesRequest)
    end
  end
  describe "#query" do
    it "should be empty" do
      request = CharacterRacesRequest.new()
      request.query.should(be == {})
    end
  end
  describe "#uri" do
    it "should be created dynamically" do
      request = CharacterRacesRequest.new()
      request.uri.should == URI.parse("http://us.battle.net/api/wow/data/character/races")
    end
  end
  describe "#invoke" do
    it "should return a valid item record", :live => true do
      request = CharacterRacesRequest.new()
      response = request.invoke
      response.should(be_a(Hash))
      response["races"].should(be_a(Array))
      response["races"][0].should(be_a(Hash))
      response["races"][0]["id"].should(be_a(Integer))
      response["races"][0]["mask"].should(be_a(Integer))
      response["races"][0]["side"].should(be_a(String))
      response["races"][0]["name"].should(be_a(String))
    end
  end
end