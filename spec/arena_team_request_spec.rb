require "rspec_helper"
require "../lib/arena_team_request"

include WOW

describe ArenaTeamRequest do
  describe "::new" do
    it "should create a new ArenaTeamRequest if valid" do
      request = ArenaTeamRequest.new("Draenor","3v3","Super Squishy")
      request.should be_instance_of(ArenaTeamRequest)
      request.realm.should(be == "Draenor")
      request.team_size.should(be == "3v3")
      request.team_name.should(be == "Super Squishy")
    end
    it "should require a non-empty string for realm, team_size and team_name" do
      lambda{ArenaTeamRequest.new(nil,"3v3","Super Squishy")}.should raise_error(SyntaxError)
      lambda{ArenaTeamRequest.new("","3v3","Super Squishy")}.should raise_error(SyntaxError)
      lambda{ArenaTeamRequest.new(3,"3v3","Super Squishy")}.should raise_error(SyntaxError)
      lambda{ArenaTeamRequest.new("Draenor",nil,"Super Squishy")}.should raise_error(SyntaxError)
      lambda{ArenaTeamRequest.new("Draenor","","Super Squishy")}.should raise_error(SyntaxError)
      lambda{ArenaTeamRequest.new("Draenor",3,"Super Squishy")}.should raise_error(SyntaxError)
      lambda{ArenaTeamRequest.new("Draenor","3v3",nil)}.should raise_error(SyntaxError)
      lambda{ArenaTeamRequest.new("Draenor","3v3","")}.should raise_error(SyntaxError)
      lambda{ArenaTeamRequest.new("Draenor","3v3",3)}.should raise_error(SyntaxError)
    end
  end
  describe "#query" do
    it "should be empty" do
      request = ArenaTeamRequest.new("Draenor","3v3","Super Squishy")
      request.query.should == {}
    end
  end
  describe "#uri" do
    it "should be created dynamically" do
      request = ArenaTeamRequest.new("Draenor","3v3","Super Squishy")
      request.uri.should == URI.parse("http://us.battle.net/api/wow/arena/Draenor/3v3/Super%20Squishy")
    end
  end
  describe "#invoke" do
    it "should return a valid character record", :live => true do
      request = ArenaTeamRequest.new("Draenor","3v3","Super Squishy")
      response = request.invoke
      response.should(be_a(Hash))
    end
  end
end