class PlayerController < ApplicationController
  def show
    player_id = params[:id].to_i
    stored_match_ids = PlayerMatch.where(player_id: player_id).map(&:match_id)
    my_stats = []

    stored_match_ids.each do |match_id|
      match = PlayerMatch.where(match_id: match_id, player_id: player_id).first
      my_stats << { match_id: match.match_id, hero: get_hero_name(match.hero_id), gold_per_minute: match.gold_per_minute, days_ago: get_days_ago(match.start_time), duration_in_minutes: get_duration_in_minutes(match.duration)}
    end

    @stats = my_stats.sort_by! { |game| game[:gold_per_minute] }.reverse!

    update_matches_from_api(player_id, stored_match_ids)


  end

  private
    def update_matches_from_api(player_id, stored_match_ids)
      require 'open-uri'

      dota_match_ids = []

      begin
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
    
        nonpersisted_matches = dota_match_ids - stored_match_ids

        puts "nonpersisted_matches"
        puts nonpersisted_matches

        nonpersisted_matches.each do |id|
          puts "making match"
          PlayerMatchWorker.perform_async(id, player_id)

          flash[:notice] = "Downloading match id #{id} from steam; reload the page in a minute"
        end

      rescue => e
        puts "Error during processing: #{$!}"
        puts "Backtrace:\n\t#{e.backtrace.join("\n\t")}"
      end
    end

end
