require "rspec_helper"
require "../lib/character_classes_request"

include WOW

describe CharacterClassesRequest do
  describe "::new" do
    it "should create a new CharacterClassesRequest if valid" do
      request = CharacterClassesRequest.new()
      request.should be_instance_of(CharacterClassesRequest)
    end
  end
  describe "#query" do
    it "should be empty" do
      request = CharacterClassesRequest.new()
      request.query.should(be == {})
    end
  end
  describe "#uri" do
    it "should be created dynamically" do
      request = CharacterClassesRequest.new()
      request.uri.should == URI.parse("http://us.battle.net/api/wow/data/character/classes")
    end
  end
  describe "#invoke" do
    it "should return a valid item record", :live => true do
      request = CharacterClassesRequest.new()
      response = request.invoke
      response.should(be_a(Hash))
      response["classes"].should(be_a(Array))
      response["classes"][0].should(be_a(Hash))
      response["classes"][0]["id"].should(be_a(Integer))
      response["classes"][0]["mask"].should(be_a(Integer))
      response["classes"][0]["powerType"].should(be_a(String))
      response["classes"][0]["name"].should(be_a(String))
    end
  end
end