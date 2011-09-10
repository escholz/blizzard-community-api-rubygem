require "rspec"
require "character"

describe BattleNet::Character do
  describe "::profile" do
    it "should require a non-empty string for name and realm" do
      BattleNet::Character.profile("", "realm").should(raise_error(SyntaxError))
      BattleNet::Character.profile(nil, "realm").should(raise_error(SyntaxError))
      BattleNet::Character.profile("name", "").should(raise_error(SyntaxError))
      BattleNet::Character.profile("name", nil).should(raise_error(SyntaxError))
      BattleNet::Character.profile(5, "").should(raise_error(SyntaxError))
    end
  end
end