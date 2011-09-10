module BattleNet
  API_ROOT_PATH = "/api/wow"

  API_LOCALES = [
    :en_US,
    :es_MX,
    :en_GB,
    :es_ES,
    :fr_FR,
    :ru_RU,
    :de_DE,
    :ko_KR,
    :zh_TW,
    :zh_CN,
  ].freeze()

  API_HOST_NAMES = {
    :en_US => "us.battle.net",
    :es_MX => "us.battle.net",
    :en_GB => "eu.battle.net",
    :es_ES => "eu.battle.net",
    :fr_FR => "eu.battle.net",
    :ru_RU => "eu.battle.net",
    :de_DE => "eu.battle.net",
    :ko_KR => "kr.battle.net",
    :zh_TW => "tw.battle.net",
    :zh_CN => "battlenet.com.cn",
  }.freeze()

  CHARACTER_PROFILE_FIELDS = {
    :guild        => "guild",
    :items        => "items",
    :professions  => "professions",
    :reputation   => "reputation",
    :stats        => "stats",
    :talents      => "talents",
    :titles       => "titles",
    :appearance   => "appearance",
    :companions   => "companions",
    :mounts       => "mounts",
    :pets         => "pets",
    :achievements => "achievements",
    :progression  => "progression",
    :pvp          => "pvp",
    :quests       => "quests",
  }.freeze()

  GUILD_PROFILE_FIELDS = {
    :members      => "members",
    :achievements => "achievements",
  }.freeze()

  ARENA_TEAM_SIZES = [
    "2v2",
    "3v3",
    "4v4",
    "5v5",
  ].freeze()

  class HttpClientError < RuntimeError
  end

  class HttpServerError < RuntimeError
  end

  class HttpNotModifiedError < RuntimeError
  end
end