class PlayerMatch < ActiveRecord::Base
  validates :match_id, uniqueness: { scope: :player_id,
    message: "should only have 1 match / player pair" }

  validates_with LevelZeroValidator
end
