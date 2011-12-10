require "rspec_helper"
require "../lib/item_classes_request"

include WOW

describe ItemClassesRequest do
  describe "::new" do
    it "should create a new ItemClassesRequest if valid" do
      request = ItemClassesRequest.new()
      request.should be_instance_of(ItemClassesRequest)
    end
  end
  describe "#query" do
    it "should be empty" do
      request = ItemClassesRequest.new()
      request.query.should(be == {})
    end
  end
  describe "#uri" do
    it "should be created dynamically" do
      request = ItemClassesRequest.new()
      request.uri.should == URI.parse("http://us.battle.net/api/wow/data/item/classes")
    end
  end
  describe "#invoke" do
    it "should return a valid item record", :live => true do
      request = ItemClassesRequest.new()
      response = request.invoke
      response.should(be_a(Hash))
      response["classes"].should(be_a(Array))
      response["classes"][0].should(be_a(Hash))
      response["classes"][0]["class"].should(be_a(Integer))
      response["classes"][0]["name"].should(be_a(String))
    end
  end
end