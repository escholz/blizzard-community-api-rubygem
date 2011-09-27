require "rspec"
require "../lib/character_profile_request"

include BattleNet

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
end