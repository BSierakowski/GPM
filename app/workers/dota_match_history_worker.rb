class DotaMatchHistoryWorker
  include Sidekiq::Worker
  require 'open-uri'

  def perform(player_id)
    stored_match_ids = PlayerMatch.where(player_id: player_id).map(&:match_id)
    dota_match_ids = get_matches_from_api(player_id)
    nonpersisted_matches = dota_match_ids - stored_match_ids

    unless nonpersisted_matches.nil? 
      nonpersisted_matches.each do |match_id|
        PlayerMatchWorker.perform_async(match_id)
      end
    end
  end

  def get_matches_from_api(player_id)
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
