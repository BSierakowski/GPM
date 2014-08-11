class MatchStatsController < ApplicationController
  def show
    id = params[:id]
    api_key = ENV['STEAM_API_KEY']

    dota_match = JSON.load(open("https://api.steampowered.com/IDOTA2Match_570/GetMatchDetails/V001/?match_id=#{id}&key=#{api_key}"))

    @players = dota_match["result"]["players"]
  end

end
