class GpmSearchesController < ApplicationController
  before_action :set_gpm_search, only: [:show, :edit, :update, :destroy]

  # GET /gpm_searches
  # GET /gpm_searches.json
  def index
    @gpm_searches = GpmSearch.all
  end

  # GET /gpm_searches/1
  # GET /gpm_searches/1.json
  def show
    require 'open-uri'

    @gpm_search = GpmSearch.find(params[:id])

    api_key = "F826AD3A1A40C01E5BB4E8496830CD1A"
    player_steam_id = @gpm_search.player_id
    requested_number_of_matches = 50

    all_matches = JSON.load(open("https://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/V001/?key=#{api_key}&account_id=#{player_steam_id}&matches_requested=#{requested_number_of_matches}"))
    match_ids = []

    all_matches["result"]["matches"].each do |match|
      match_ids.push(match["match_id"])
    end

    my_games = {}
    my_stats = []

    match_ids.each do |id|
      begin 
        puts "match id: #{id}"
        dota_match = JSON.load(open("https://api.steampowered.com/IDOTA2Match_570/GetMatchDetails/V001/?match_id=#{id}&key=#{api_key}"))
        puts "player id: #{player_steam_id}"
        my_games[id] = dota_match["result"]["players"].select {|player| player["account_id"] == player_steam_id }
        my_stats << { match_id: id, hero: get_hero_name(my_games[id].first["hero_id"]), gold_per_minute: my_games[id].first["gold_per_min"], days_ago: get_days_ago(dota_match["result"]["start_time"]), duration_in_minutes: get_duration_in_minutes(dota_match["result"]["duration"])}
      rescue => e
        puts "there was an error #{e}"
      end
    end

    my_stats.sort_by! { |game| game[:gold_per_minute] }.reverse!

    @stats = my_stats
  end

  # GET /gpm_searches/new
  def new
    @gpm_search = GpmSearch.new
  end

  # GET /gpm_searches/1/edit
  def edit
  end

  # POST /gpm_searches
  # POST /gpm_searches.json
  def create
    @gpm_search = GpmSearch.new(gpm_search_params)

    respond_to do |format|
      if @gpm_search.save
        format.html { redirect_to @gpm_search, notice: 'Gpm search was successfully created.' }
        format.json { render action: 'show', status: :created, location: @gpm_search }
      else
        format.html { render action: 'new' }
        format.json { render json: @gpm_search.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gpm_searches/1
  # PATCH/PUT /gpm_searches/1.json
  def update
    respond_to do |format|
      if @gpm_search.update(gpm_search_params)
        format.html { redirect_to @gpm_search, notice: 'Gpm search was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @gpm_search.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gpm_searches/1
  # DELETE /gpm_searches/1.json
  def destroy
    @gpm_search.destroy
    respond_to do |format|
      format.html { redirect_to gpm_searches_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gpm_search
      @gpm_search = GpmSearch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gpm_search_params
      params.require(:gpm_search).permit(:player_id)
    end

    def get_hero_name(id)
      heros = {
        1 => "Anti-Mage",
        2 => "Axe",
        3 => "Bane",
        4 => "Bloodseeker",
        5 => "Crystal Maiden",
        6 => "Drow Ranger",
        7 => "Earthshaker",
        8 => "Juggernaut",
        9 => "Mirana",
        11 => "Shadow Fiend",
        10 => "Morphling",
        12 => "Phantom Lancer",
        13 => "Puck",
        14 => "Pudge",
        15 => "Razor",
        16 => "Sand King",
        17 => "Storm Spirit",
        18 => "Sven",
        19 => "Tiny",
        20 => "Vengeful Spirit",
        21 => "Windrunner",
        22 => "Zeus",
        23 => "Kunkka",
        25 => "Lina",
        31 => "Lich",
        26 => "Lion",
        27 => "Shadow Shaman",
        28 => "Slardar",
        29 => "Tidehunter",
        30 => "Witch Doctor",
        32 => "Riki",
        33 => "Enigma",
        34 => "Tinker",
        35 => "Sniper",
        36 => "Necrolyte",
        37 => "Warlock",
        38 => "Beastmaster",
        39 => "Queen of Pain",
        40 => "Venomancer",
        41 => "Faceless Void",
        42 => "Skeleton King",
        43 => "Death Prophet",
        44 => "Phantom Assassin",
        45 => "Pugna",
        46 => "Templar Assassin",
        47 => "Viper",
        48 => "Luna",
        49 => "Dragon Knight",
        50 => "Dazzle",
        51 => "Clockwerk",
        52 => "Leshrac",
        53 => "Nature's Prophet",
        54 => "Lifestealer",
        55 => "Dark Seer",
        56 => "Clinkz",
        57 => "Omniknight",
        58 => "Enchantress",
        59 => "Huskar",
        60 => "Night Stalker",
        61 => "Broodmother",
        62 => "Bounty Hunter",
        63 => "Weaver",
        64 => "Jakiro",
        65 => "Batrider",
        66 => "Chen",
        67 => "Spectre",
        69 => "Doom",
        68 => "Ancient Apparition",
        70 => "Ursa",
        71 => "Spirit Breaker",
        72 => "Gyrocopter",
        73 => "Alchemist",
        74 => "Invoker",
        75 => "Silencer",
        76 => "Outworld Devourer",
        77 => "Lycanthrope",
        78 => "Brewmaster",
        79 => "Shadow Demon",
        80 => "Lone Druid",
        81 => "Chaos Knight",
        82 => "Meepo",
        83 => "Treant Protector",
        84 => "Ogre Magi",
        85 => "Undying",
        86 => "Rubick",
        87 => "Disruptor",
        88 => "Nyx Assassin",
        89 => "Naga Siren",
        90 => "Keeper of the Light",
        91 => "Wisp",
        92 => "Visage",
        93 => "Slark",
        94 => "Medusa",
        95 => "Troll Warlord",
        96 => "Centaur Warrunner",
        97 => "Magnus",
        98 => "Timbersaw",
        99 => "Bristlebog",
        100 => "Tusk",
        101 => "Skywrath Mage",
        102 => "Abaddon",
        103 => "Elder Titan",
        104 => "Legion Commander",
        106 => "Ember Spirit",
        107 => "Earth Spirit",
        108 => "Abyssal Underlord",
        109 => "Terrorblade",
        110 => "Phoenix"
      }

      return heros[id]
    end

def get_days_ago(seconds_since_epoch)
  difference_in_seconds = Time.now - Time.at(seconds_since_epoch)
  time_in_days = difference_in_seconds/60/60/24

  return time_in_days.round(1)
end

def get_duration_in_minutes(seconds)
  return seconds/60
end
end
