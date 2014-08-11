class MatchStatsController < ApplicationController
  def show
    id = params[:id]
    api_key = ENV['STEAM_API_KEY']

    dota_match = JSON.load(open("https://api.steampowered.com/IDOTA2Match_570/GetMatchDetails/V001/?match_id=#{id}&key=#{api_key}"))

    @players = dota_match["result"]["players"]

    # To get hero hp, ill need to get base HP + strength gain + levels * 19, + 38 per ever level of stats, plus any hp given from items, plus any strength given from items * 19. wow.
  end

end
