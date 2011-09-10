# Sections of this library can be turned off if you wish.

# Holds the static defaults
require "configuration.rb"
# This is only required if you need authenticated request support
require "authorized_api_request"
# You only need this if you're making character requests
require "character_profile_request.rb"
# You only need this if you're making guild requests
require 'guild_profile_request.rb'