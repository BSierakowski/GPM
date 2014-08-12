class PlayerController < ApplicationController
  def show
    my_stats = []
    player_id = params[:id].to_i
    player_matches = PlayerMatch.where(player_id: player_id)
    
    player_matches.each do |match|
      my_stats << { match_id: match.match_id, hero: get_hero_name(match.hero_id), gold_per_minute: match.gold_per_minute, days_ago: get_days_ago(match.start_time), duration_in_minutes: get_duration_in_minutes(match.duration)}
    end

    @stats = my_stats.sort_by! { |game| game[:gold_per_minute] }.reverse!

    DotaMatchHistoryWorker.perform_async(player_id)
  end
end
