require 'api_request'

module WOW
  class ArenaTeamRequest < ApiRequest

    def initialize(realm, team_size, team_name, options={})
      super(options)
      if(!realm.is_a?(String) || realm.empty? || !team_size.is_a?(String) || team_size.empty? || !team_name.is_a?(String) || team_name.empty?)
        raise(SyntaxError, "Realm, TeamSize and TeamName must be non-empty string values")
      end
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