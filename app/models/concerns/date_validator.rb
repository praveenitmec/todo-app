
class DateValidator < ActiveModel::Validator
  def validate(record)
    if record.target_date < DateTime.now
      record.errors[:target_date] << "Create Todo In Future date"
    end
  end
end
