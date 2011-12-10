require "rspec_helper"
require "../lib/guild_rewards_request"

include WOW

describe GuildRewardsRequest do
  describe "::new" do
    it "should create a new GuildRewardsRequest if valid" do
      request = GuildRewardsRequest.new()
      request.should be_instance_of(GuildRewardsRequest)
    end
  end
  describe "#query" do
    it "should be empty" do
      request = GuildRewardsRequest.new()
      request.query.should(be == {})
    end
  end
  describe "#uri" do
    it "should be created dynamically" do
      request = GuildRewardsRequest.new()
      request.uri.should == URI.parse("http://us.battle.net/api/wow/data/guild/rewards")
    end
  end
  describe "#invoke" do
    it "should return a valid item record", :live => true do
      request = GuildRewardsRequest.new()
      response = request.invoke
      response.should(be_a(Hash))
      response["rewards"].should(be_a(Array))
      response["rewards"][0].should(be_a(Hash))
      response["rewards"][0]["minGuildLevel"].should(be_a(Integer))
      response["rewards"][0]["minGuildRepLevel"].should(be_a(Integer))
      response["rewards"][0]["achievement"].should(be_a(Hash))
      response["rewards"][0]["achievement"]["id"].should(be_a(Integer))
      response["rewards"][0]["achievement"]["title"].should(be_a(String))
      response["rewards"][0]["achievement"]["points"].should(be_a(Integer))
      response["rewards"][0]["achievement"]["description"].should(be_a(String))
      response["rewards"][0]["achievement"]["reward"].should(be_a(String))
      response["rewards"][0]["achievement"]["rewardItem"].should(be_a(Hash))
      response["rewards"][0]["achievement"]["rewardItem"]["id"].should(be_a(Integer))
      response["rewards"][0]["achievement"]["rewardItem"]["name"].should(be_a(String))
      response["rewards"][0]["achievement"]["rewardItem"]["icon"].should(be_a(String))
      response["rewards"][0]["achievement"]["rewardItem"]["quality"].should(be_a(Integer))
      response["rewards"][0]["achievement"]["rewardItem"]["tooltipParams"].should(be_a(Hash))
      response["rewards"][0]["item"].should(be_a(Hash))
      response["rewards"][0]["item"]["id"].should(be_a(Integer))
      response["rewards"][0]["item"]["name"].should(be_a(String))
      response["rewards"][0]["item"]["icon"].should(be_a(String))
      response["rewards"][0]["item"]["quality"].should(be_a(Integer))
      response["rewards"][0]["item"]["tooltipParams"].should(be_a(Hash))
    end
  end
end