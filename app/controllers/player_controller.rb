class PlayerController < ApplicationController
  def show
    my_stats = []
    player_id = params[:id].to_i
    player_matches = PlayerMatch.where(player_id: player_id)
    
    player_matches.each do |match|
      my_stats << { match_id: match.match_id, hero: get_hero_name(match.hero_id), gold_per_minute: match.gold_per_minute, days_ago: get_days_ago(match.start_time), duration_in_minutes: get_duration_in_minutes(match.duration)}
    end

    @stats = my_stats.sort_by! { |game| game[:gold_per_minute] }.reverse!

    update_matches(player_id)
  end

  def update_matches(player_id)
    stored_match_ids = PlayerMatch.where(player_id: player_id).map(&:match_id)
    dota_match_ids = get_matches_from_api(player_id)
    nonpersisted_matches = dota_match_ids - stored_match_ids

    nonpersisted_matches.each do |match|
      PlayerMatchWorker.perform_async(match)
    end
  end

  def get_matches_from_api(player_id)
    # Would love to get the the F out of the controller and into another worker
    require 'open-uri'

    dota_match_ids = []

    first_match_page = JSON.load(open("https://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/V001/?key=#{ENV["STEAM_API_KEY"]}&account_id=#{player_id}&matches_requested=100"))

    first_match_page["result"]["matches"].each do |match|
      dota_match_ids.push(match["match_id"])
    end

    4.times do 
      match_page = JSON.load(open("https://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/V001/?key=#{ENV["STEAM_API_KEY"]}&account_id=#{player_id}&matches_requested=100&start_at_match_id=#{dota_match_ids.last-1}"))
      
      match_page["result"]["matches"].each do |match|
        dota_match_ids.push(match["match_id"])
      end
    end

    return dota_match_ids
  end
end
