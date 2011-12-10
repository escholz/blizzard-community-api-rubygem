require "rspec_helper"
require "../lib/guild_profile_request"

include WOW

describe GuildProfileRequest do
  describe "::new" do
    it "should create a new GuildProfileRequest if valid" do
      request = GuildProfileRequest.new("Little Urban Elites","Draenor",:fields => [:members, :achievements])
      request.should be_instance_of(GuildProfileRequest)
      request.name.should == "Little Urban Elites"
      request.realm.should == "Draenor"
      request.fields.should == [:members, :achievements]
    end
    it "should require a non-empty string for name and realm" do
      lambda{GuildProfileRequest.new("", "realm")}.should raise_error(SyntaxError)
      lambda{GuildProfileRequest.new(nil, "realm")}.should raise_error(SyntaxError)
      lambda{GuildProfileRequest.new("name", "")}.should raise_error(SyntaxError)
      lambda{GuildProfileRequest.new("name", nil)}.should raise_error(SyntaxError)
      lambda{GuildProfileRequest.new(5, "")}.should raise_error(SyntaxError)
    end
    it "should require an array of fields if fields are supplied" do
      lambda{GuildProfileRequest.new("Little Urban Elites","Draenor",:fields => :members)}.should raise_error(SyntaxError)
      lambda{GuildProfileRequest.new("Little Urban Elites","Draenor",:fields => { :members => false, :achievements => true })}.should raise_error(SyntaxError)
      GuildProfileRequest.new("Little Urban Elites","Dreanor",:fields => nil).should be_instance_of(GuildProfileRequest)
      GuildProfileRequest.new("Little Urban Elites","Dreanor").should be_instance_of(GuildProfileRequest)
    end
    it "should return additional information if fields collection contains token", :live => true do
      request = GuildProfileRequest.new("Little Urban Elites","Draenor",:fields => [ :members, :achievements ])
      response = request.invoke
      response.should(be_a(Hash))
      response["members"].should(be_a(Array))
      response["achievements"].should(be_a(Hash))
    end
  end
  describe "#query" do
    it "should be created dynamically" do
      request = GuildProfileRequest.new("Little Urban Elites","Draenor",:fields => [:members, :achievements])
      request.query.should == {"fields" => [ :members, :achievements ]}
    end
  end
  describe "#uri" do
    it "should be created dynamically" do
      request = GuildProfileRequest.new("Little Urban Elites","Draenor",:fields => [:members, :achievements])
      request.uri.should == URI.parse("http://us.battle.net/api/wow/guild/Draenor/Little%20Urban%20Elites?fields=members,achievements")
    end
  end
  describe "#invoke" do
    it "should return a valid guild record", :live => true do
      request = GuildProfileRequest.new("Little Urban Elites","Draenor")
      response = request.invoke
      response.should(be_a(Hash))
      response["name"].should(be_a(String))
      response["level"].should(be_a(Integer))
      response["side"].should(be_a(Numeric))
      response["achievementPoints"].should(be_a(Integer))
    end
  end
end