class AddPlayerIdToGpmSearches < ActiveRecord::Migration
  def change
    add_column :gpm_searches, :player_id, :integer
  end
end
