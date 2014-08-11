class CreatePlayerMatch < ActiveRecord::Migration
  def change
    create_table :player_matches do |t|
      t.integer :match_id, null: false
      t.integer :player_id, null: false
      t.integer :player_slot, null: false
      t.integer :hero_id, null: false
      t.integer :item_0, null: false
      t.integer :item_1, null: false
      t.integer :item_2, null: false
      t.integer :item_3, null: false
      t.integer :item_4, null: false
      t.integer :item_5, null: false
      t.integer :kills, null: false
      t.integer :deaths, null: false
      t.integer :assists, null: false
      t.integer :leaver_status, null: false
      t.integer :gold, null: false
      t.integer :last_hits, null: false
      t.integer :denies, null: false
      t.integer :gold_per_minute, null: false
      t.integer :xp_per_minute, null: false
      t.integer :gold_spent, null: false
      t.integer :hero_damage, null: false
      t.integer :tower_damage, null: false
      t.integer :hero_healing, null: false
      t.integer :level, null: false
      t.text :ability_upgrades, array: true, null: false
      t.boolean :radiant_win, null: false
      t.integer :duration, null: false
      t.integer :start_time, null: false
      t.integer :match_seq_num, null: false
      t.integer :tower_status_radiant, null: false
      t.integer :tower_status_dire, null: false
      t.integer :barracks_status_radiant, null: false
      t.integer :barracks_status_dire, null: false
      t.integer :cluster, null: false
      t.integer :first_blood_time, null: false
      t.integer :lobby_type, null: false
      t.integer :human_players, null: false
      t.integer :leagueid, null: false
      t.integer :positive_votes, null: false
      t.integer :negative_votes, null: false
      t.integer :game_mode, null: false
      t.integer :radiant_captain, null: false
      t.integer :dire_captain, null: false
    end
  end
end



