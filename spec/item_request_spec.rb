require "rspec_helper"
require "../lib/item_request"

include WOW

describe ItemRequest do
  describe "::new" do
    it "should create a new ItemRequest if valid" do
      request = ItemRequest.new(78473)
      request.should be_instance_of(ItemRequest)
      request.item_id.should == 78473
    end
    it "should require an integer for item_id" do
      lambda{ItemRequest.new("")}.should raise_error(SyntaxError)
      lambda{ItemRequest.new(nil)}.should raise_error(SyntaxError)
      lambda{ItemRequest.new(true)}.should raise_error(SyntaxError)
    end
  end
  describe "#query" do
    it "should be empty" do
      request = ItemRequest.new(78473)
      request.query.should(be == {})
    end
  end
  describe "#uri" do
    it "should be created dynamically" do
      request = ItemRequest.new(78473)
      request.uri.should == URI.parse("http://us.battle.net/api/wow/item/78473")
    end
  end
  describe "#invoke" do
    it "should return a valid item record", :live => true do
      request = ItemRequest.new(78473)
      response = request.invoke
      response.should(be_a(Hash))
      response["id"].should(be_a(Integer))
      response["disenchantingSkillRank"].should(be_a(Integer))
      response["description"].should(be_a(String))
      response["name"].should(be_a(String))
      response["stackable"].should(be_a(Integer))
      response["itemBind"].should(be_a(Integer))
      response["bonusStats"].should(be_a(Array))
      response["itemSpells"].should(be_a(Array))
      response["buyPrice"].should(be_a(Integer))
      response["itemClass"].should(be_a(Integer))
      response["itemSubClass"].should(be_a(Integer))
      response["containerSlots"].should(be_a(Integer))
      response["weaponInfo"].should(be_a(Hash))
      response["weaponInfo"]["damage"].should(be_a(Hash))
      response["weaponInfo"]["damage"]["min"].should(be_a(Integer))
      response["weaponInfo"]["damage"]["max"].should(be_a(Integer))
      response["weaponInfo"]["weaponSpeed"].should(be_a(Float))
      response["weaponInfo"]["dps"].should(be_a(Float))
      response["inventoryType"].should(be_a(Integer))
      response["equippable"].should(be_boolean)
      response["itemLevel"].should(be_a(Integer))
      response["maxCount"].should(be_a(Integer))
      response["maxDurability"].should(be_a(Integer))
      response["minFactionId"].should(be_a(Integer))
      response["minReputation"].should(be_a(Integer))
      response["quality"].should(be_a(Integer))
      response["sellPrice"].should(be_a(Integer))
      response["requiredLevel"].should(be_a(Integer))
      response["requiredSkill"].should(be_a(Integer))
      response["requiredSkillRank"].should(be_a(Integer))
      response["itemSource"].should(be_a(Hash))
      response["itemSource"]["sourceId"].should(be_a(Integer))
      response["itemSource"]["sourceType"].should(be_a(String))
      response["baseArmor"].should(be_a(Integer))
      response["hasSockets"].should(be_boolean)
      response["isAuctionable"].should(be_boolean)
    end
  end
end