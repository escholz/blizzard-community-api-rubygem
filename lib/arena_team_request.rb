require 'api_request'

module BattleNet
  class ArenaTeamRequest < ApiRequest

    def initialize(realm, team_size, team_name, options={})
      super(options)
      @realm = realm
      @team_size = team_size
      @team_name = team_name
    end

    attr_reader :realm, :team_size, :team_name

    def path
      "#{super}/arena/#{uri_encode(realm)}/#{uri_encode(team_size)}/#{uri_encode(team_name)}"
    end

  end
end