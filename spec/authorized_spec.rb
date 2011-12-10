require "rspec_helper"
require "../lib/blizzard-community-api"

include WOW

describe API::Authorized do
  before(:all) do
    Configuration.public_key = "--DONT-CHECK-IN-KEYS--"
    Configuration.private_key = "--DONT-CHECK-IN-KEYS--"
  end

  describe "::get_character_profile" do
    it "should invoke a CharacterProfileRequest and return a response Hash", :live => true do
      response = API::Authorized.get_character_profile("Aven","Draenor")
      response.should(be_a(Hash))
      response["name"].should(be == "Aven")
    end
  end
  describe "::get_guild_profile" do
    it "should invoke a GuildProfileRequest and return a response Hash", :live => true do
      response = API::Authorized.get_guild_profile("Little Urban Elites","Draenor")
      response.should(be_a(Hash))
      response["name"].should(be == "Little Urban Elites")
    end
  end
  describe "::get_arena_team" do
    it "should invoke a ArenaTeamRequest and return a response Hash", :live => true do
      response = API.get_arena_team("Draenor","3v3","Super Squishy")
      response.should(be_a(Hash))
      response["name"].should(be == "Super Squishy")
    end
  end
  describe "::get_character_classes" do
    it "should invoke a CharacterClassesRequest and return a response Hash", :live => true do
      response = API::Authorized.get_character_classes()
      response.should(be_a(Hash))
      response["classes"].should(be_a(Array))
    end
  end
  describe "::get_character_races" do
    it "should invoke a CharacterRacesRequest and return a response Hash", :live => true do
      response = API::Authorized.get_character_races()
      response.should(be_a(Hash))
      response["races"].should(be_a(Array))
    end
  end
  describe "::get_current_auctions" do
    it "should invoke a CurrentAuctionsRequest and return a response Hash", :live => true do
      response = API::Authorized.get_current_auctions("Draenor")
      response.should(be_a(Hash))
      response["files"].should(be_a(Array))
    end
  end
  describe "::get_guild_perks" do
    it "should invoke a GuildPerksRequest and return a response Hash", :live => true do
      response = API::Authorized.get_guild_perks()
      response.should(be_a(Hash))
      response["perks"].should(be_a(Array))
    end
  end
  describe "::get_guild_rewards" do
    it "should invoke a GuildRewardsRequest and return a response Hash", :live => true do
      response = API::Authorized.get_guild_rewards()
      response.should(be_a(Hash))
      response["rewards"].should(be_a(Array))
    end
  end
  describe "::get_item_classes" do
    it "should invoke a ItemClassesRequest and return a response Hash", :live => true do
      response = API::Authorized.get_item_classes()
      response.should(be_a(Hash))
      response["classes"].should(be_a(Array))
    end
  end
  describe "::get_item" do
    it "should invoke a ItemRequest and return a response Hash", :live => true do
      response = API::Authorized.get_item(78473)
      response.should(be_a(Hash))
      response["id"].should(be == 78473)
    end
  end
  describe "::get_realm_status" do
    it "should invoke a RealmStatusRequest and return a response Hash", :live => true do
      response = API::Authorized.get_realm_status()
      response.should(be_a(Hash))
      response["realms"].should(be_a(Array))
    end
  end
end