class CreateGpmSearches < ActiveRecord::Migration
  def change
    create_table :gpm_searches do |t|

      t.timestamps
    end
  end
end
