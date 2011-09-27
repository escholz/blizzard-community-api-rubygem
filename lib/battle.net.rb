# Holds the static defaults
require "configuration"

# The following includes are request objects.
# You can feel free to comment out any of them you don't intend to use
# TODO: Dynamically load these via factory interface

# This is only required if you need authorized request support
require "authorized_api_request"
# You only need this if you're making character requests
require "character_profile_request"
require "character_classes_request"
require "character_races_request"
# You only need this if you're making guild requests
require "guild_profile_request"
require "guild_perks_request"
require "guild_rewards_request"
# You only need this if you're making item requests
require "item_request"
require "item_classes_request"
# You only need this if you're making PvP related requests
require "arena_team_request"
# You only need this if you're making auction house requests
require "current_auctions_request"
# You only need this if you're making realm status requests
require "realm_status_request"