require "rspec_helper"
require "../lib/current_auctions_request"

include WOW

describe CurrentAuctionsRequest do
  describe "::new" do
    it "should create a new CurrentAuctionsRequest if valid" do
      request = CurrentAuctionsRequest.new("Draenor")
      request.should be_instance_of(CurrentAuctionsRequest)
      request.realm.should == "Draenor"
    end
    it "should require a non-empty string for realm" do
      lambda{CurrentAuctionsRequest.new("")}.should raise_error(SyntaxError)
      lambda{CurrentAuctionsRequest.new(nil)}.should raise_error(SyntaxError)
      lambda{CurrentAuctionsRequest.new(5)}.should raise_error(SyntaxError)
    end
  end
  describe "#query" do
    it "should be empty" do
      request = CurrentAuctionsRequest.new("Draenor")
      request.query.should(be == {})
    end
  end
  describe "#uri" do
    it "should be created dynamically" do
      request = CurrentAuctionsRequest.new("Draenor")
      request.uri.should == URI.parse("http://us.battle.net/api/wow/auction/data/draenor")
    end
  end
  describe "#invoke" do
    it "should return a valid guild record", :live => true do
      request = CurrentAuctionsRequest.new("Draenor")
      response = request.invoke
      response.should(be_a(Hash))
      response["files"].should(be_a(Array))
      response["files"][0]["url"].should(be_a(String))
      response["files"][0]["lastModified"].should(be_a(Numeric))
    end
  end
end