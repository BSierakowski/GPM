class PlayerMatchWorker
  include Sidekiq::Worker
  require 'open-uri'

  def perform(id, player_id)
    dota_match = JSON.load(open("https://api.steampowered.com/IDOTA2Match_570/GetMatchDetails/V001/?match_id=#{id}&key=#{ENV["STEAM_API_KEY"]}"))
    dota_match = dota_match["result"]
    player_stats = dota_match["players"].select {|player| player["account_id"] == player_id }
    player_stats = player_stats.first

    # a part of me feels like I should just iterate the hash and create the row based off of key value pairs
    match = PlayerMatch.new(
      match_id: id.to_i,
      player_id: player_id.to_i,
      player_slot: player_stats["player_slot"].to_i,
      hero_id: player_stats["hero_id"].to_i,
      item_0: player_stats["item_0"].to_i,
      item_1: player_stats["item_1"].to_i,
      item_2: player_stats["item_2"].to_i,
      item_3: player_stats["item_3"].to_i,
      item_4: player_stats["item_4"].to_i,
      item_5: player_stats["item_5"].to_i,
      kills: player_stats["kills"].to_i,
      deaths: player_stats["deaths"].to_i,
      assists: player_stats["assists"].to_i,
      leaver_status: player_stats["leaver_status"].to_i,
      gold: player_stats["gold"].to_i,
      last_hits: player_stats["last_hits"].to_i,
      denies: player_stats["denies"].to_i,
      gold_per_minute: player_stats["gold_per_min"].to_i,
      xp_per_minute: player_stats["xp_per_min"].to_i,
      gold_spent: player_stats["gold_spent"].to_i,
      hero_damage: player_stats["hero_damage"].to_i,
      tower_damage: player_stats["tower_damage"].to_i,
      hero_healing: player_stats["hero_healing"].to_i,
      level: player_stats["level"].to_i,
      ability_upgrades: player_stats["ability_upgrades"].to_s,
      radiant_win: dota_match["radiant_win"],
      duration: dota_match["duration"].to_i,
      start_time: dota_match["start_time"].to_i,
      match_seq_num: dota_match["match_seq_num"].to_i,
      tower_status_radiant: dota_match["tower_status_radiant"].to_i,
      tower_status_dire: dota_match["tower_status_dire"].to_i,
      barracks_status_radiant: dota_match["barracks_status_radiant"].to_i,
      barracks_status_dire: dota_match["barracks_status_dire"].to_i,
      cluster: dota_match["cluster"].to_i,
      first_blood_time: dota_match["first_blood_time"].to_i,
      lobby_type: dota_match["lobby_type"].to_i,
      human_players: dota_match["human_players"].to_i,
      leagueid: dota_match["leagueid"].to_i,
      positive_votes: dota_match["positive_votes"].to_i,
      negative_votes: dota_match["negative_votes"].to_i,
      game_mode: dota_match["game_mode"].to_i,
      radiant_captain: dota_match["radiant_captain"].to_i,
      dire_captain: dota_match["dire_captain"].to_i
    )

    match.save
  end
end
