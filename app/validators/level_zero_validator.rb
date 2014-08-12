class LevelZeroValidator < ActiveModel::Validator
  def validate(record)
    if record.level == 0
      record.errors[:name] << "Can't be 0."
    end
  end
end
