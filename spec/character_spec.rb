require "rspec"
require "character"

describe BattleNet::Character do
  describe "::profile" do
    it "should require a non-empty string for name and realm" do
      BattleNet::Character.profile("", "realm").should(raise_exception(:invalid_argument_exception))
      BattleNet::Character.profile(nil, "realm").should(raise_exception(:invalid_argument_exception))
      BattleNet::Character.profile("name", "").should(raise_exception(:invalid_argument_exception))
      BattleNet::Character.profile("name", nil).should(raise_exception(:invalid_argument_exception))
      BattleNet::Character.profile(5, "").should(raise_exception(:invalid_argument_exception))
    end
  end
end