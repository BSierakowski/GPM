# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140811202911) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "gpm_searches", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "player_id"
  end

  create_table "player_matches", force: true do |t|
    t.integer "match_id",                limit: 8, null: false
    t.integer "player_id",               limit: 8, null: false
    t.integer "player_slot",                       null: false
    t.integer "hero_id",                           null: false
    t.integer "item_0",                            null: false
    t.integer "item_1",                            null: false
    t.integer "item_2",                            null: false
    t.integer "item_3",                            null: false
    t.integer "item_4",                            null: false
    t.integer "item_5",                            null: false
    t.integer "kills",                             null: false
    t.integer "deaths",                            null: false
    t.integer "assists",                           null: false
    t.integer "leaver_status",                     null: false
    t.integer "gold",                              null: false
    t.integer "last_hits",                         null: false
    t.integer "denies",                            null: false
    t.integer "gold_per_minute",                   null: false
    t.integer "xp_per_minute",                     null: false
    t.integer "gold_spent",                        null: false
    t.integer "hero_damage",                       null: false
    t.integer "tower_damage",                      null: false
    t.integer "hero_healing",                      null: false
    t.integer "level",                             null: false
    t.text    "ability_upgrades",                  null: false, array: true
    t.boolean "radiant_win",                       null: false
    t.integer "duration",                          null: false
    t.integer "start_time",                        null: false
    t.integer "match_seq_num",                     null: false
    t.integer "tower_status_radiant",              null: false
    t.integer "tower_status_dire",                 null: false
    t.integer "barracks_status_radiant",           null: false
    t.integer "barracks_status_dire",              null: false
    t.integer "cluster",                           null: false
    t.integer "first_blood_time",                  null: false
    t.integer "lobby_type",                        null: false
    t.integer "human_players",                     null: false
    t.integer "leagueid",                          null: false
    t.integer "positive_votes",                    null: false
    t.integer "negative_votes",                    null: false
    t.integer "game_mode",                         null: false
    t.integer "radiant_captain",                   null: false
    t.integer "dire_captain",                      null: false
  end

end
