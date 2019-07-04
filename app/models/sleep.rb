class Sleep < ApplicationRecord
  validates :slept_time, presence: true
  validates :wakeup_time, presence: true
  validate :dates_cannnot_be_registered_if_there_is_no_yesterdays_date
  belongs_to :user

  def dates_cannnot_be_registered_if_there_is_no_yesterdays_date
    return if date.present?
    if date != Sleep.last.date.tomorrow
      errors.add(:date, "You can't register that there is no data about before days.")
    end
  end
end
