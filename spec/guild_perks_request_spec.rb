require "rspec_helper"
require "../lib/guild_perks_request"

include WOW

describe GuildPerksRequest do
  describe "::new" do
    it "should create a new GuildPerksRequest if valid" do
      request = GuildPerksRequest.new()
      request.should be_instance_of(GuildPerksRequest)
    end
  end
  describe "#query" do
    it "should be empty" do
      request = GuildPerksRequest.new()
      request.query.should(be == {})
    end
  end
  describe "#uri" do
    it "should be created dynamically" do
      request = GuildPerksRequest.new()
      request.uri.should == URI.parse("http://us.battle.net/api/wow/data/guild/perks")
    end
  end
  describe "#invoke" do
    it "should return a valid item record", :live => true do
      request = GuildPerksRequest.new()
      response = request.invoke
      response.should(be_a(Hash))
      response["perks"].should(be_a(Array))
    end
  end
end