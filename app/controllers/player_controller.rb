class PlayerController < ApplicationController
  def new
  end

  def search
    redirect_to action: 'show', id: params[:query]
  end

  def show
    my_stats = []
    player_id = params[:id].to_i
    player_matches = PlayerMatch.where(player_id: player_id)
    
    player_matches.each do |match|
      if match.match_id.present?
        if match.hero_id.present?
          if match.human_players == 10
            if get_duration_in_minutes(match.duration) > 10
              my_stats << { match_id: match.match_id, hero: get_hero_name(match.hero_id), gold_per_minute: match.gold_per_minute, days_ago: get_days_ago(match.start_time), duration_in_minutes: get_duration_in_minutes(match.duration), human_players: match.human_players}
            end
          end
        end
      end
    end

    @stats = my_stats.sort_by! { |game| game[:gold_per_minute] }.reverse!

    DotaMatchHistoryWorker.perform_async(player_id)
  end
end
