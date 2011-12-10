require "rspec_helper"
require "../lib/character_profile_request"

include WOW

describe CharacterProfileRequest do
  describe "::new" do
    it "should create a new CharacterProfileRequest if valid" do
      request = CharacterProfileRequest.new("Aven","Draenor",:fields => [:stats, :talents])
      request.should be_instance_of(CharacterProfileRequest)
      request.name.should == "Aven"
      request.realm.should == "Draenor"
      request.fields.should == [:stats, :talents]
    end
    it "should require a non-empty string for name and realm" do
      lambda{CharacterProfileRequest.new("", "realm")}.should raise_error(SyntaxError)
      lambda{CharacterProfileRequest.new(nil, "realm")}.should raise_error(SyntaxError)
      lambda{CharacterProfileRequest.new("name", "")}.should raise_error(SyntaxError)
      lambda{CharacterProfileRequest.new("name", nil)}.should raise_error(SyntaxError)
      lambda{CharacterProfileRequest.new(5, "")}.should raise_error(SyntaxError)
    end
    it "should require an array of fields if fields are supplied" do
      lambda{CharacterProfileRequest.new("Aven","Draenor",:fields => :stats)}.should raise_error(SyntaxError)
      lambda{CharacterProfileRequest.new("Aven","Draenor",:fields => { :stats => false, :talents => true })}.should raise_error(SyntaxError)
      CharacterProfileRequest.new("Aven","Dreanor",:fields => nil).should be_instance_of(CharacterProfileRequest)
      CharacterProfileRequest.new("Aven","Dreanor").should be_instance_of(CharacterProfileRequest)
    end
    it "should return additional information if fields collection contains token", :live => true do
      request = CharacterProfileRequest.new("Aven","Draenor",:fields => [ :guild, :stats, :talents, :items, :reputation, :titles, :professions, :appearance, :companions, :mounts, :pets, :achievements, :progression, :pvp, :quests ])
      response = request.invoke
      response.should(be_a(Hash))
      response["guild"].should(be_a(Hash))
      response["stats"].should(be_a(Hash))
      response["talents"].should(be_a(Array))
      response["items"].should(be_a(Hash))
      response["reputation"].should(be_a(Array))
      response["titles"].should(be_a(Array))
      response["professions"].should(be_a(Hash))
      response["appearance"].should(be_a(Hash))
      response["companions"].should(be_a(Array))
      response["mounts"].should(be_a(Array))
      response["pets"].should(be_a(Array))
      response["achievements"].should(be_a(Hash))
      response["progression"].should(be_a(Hash))
      response["pvp"].should(be_a(Hash))
      response["quests"].should(be_a(Array))
    end
  end
  describe "#query" do
    it "should be created dynamically" do
      request = CharacterProfileRequest.new("Aven","Draenor",:fields => [:stats, :talents])
      request.query.should == {"fields" => [ :stats, :talents ]}
    end
  end
  describe "#uri" do
    it "should be created dynamically" do
      request = CharacterProfileRequest.new("Aven","Draenor",:fields => [:stats, :talents])
      request.uri.should == URI.parse("http://us.battle.net/api/wow/character/Draenor/Aven?fields=stats,talents")
    end
  end
  describe "#invoke" do
    it "should return a valid character record", :live => true do
      request = CharacterProfileRequest.new("Aven","Draenor")
      response = request.invoke
      response.should(be_a(Hash))
      response["realm"].should(be_a(String))
      response["name"].should(be_a(String))
      response["level"].should(be_a(Integer))
      response["lastModified"].should(be_a(Numeric))
      response["thumbnail"].should(be_a(String))
      response["race"].should(be_a(Integer))
      response["achievementPoints"].should(be_a(Integer))
      response["gender"].should(be_a(Integer))
      response["class"].should(be_a(Integer))
      response["guild"].should(be_nil)
      response["stats"].should(be_nil)
      response["talents"].should(be_nil)
      response["items"].should(be_nil)
      response["reputation"].should(be_nil)
      response["titles"].should(be_nil)
      response["professions"].should(be_nil)
      response["appearance"].should(be_nil)
      response["companions"].should(be_nil)
      response["mounts"].should(be_nil)
      response["pets"].should(be_nil)
      response["achievements"].should(be_nil)
      response["progression"].should(be_nil)
      response["pvp"].should(be_nil)
      response["quests"].should(be_nil)
    end
  end
end