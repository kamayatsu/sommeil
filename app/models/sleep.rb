class Sleep < ApplicationRecord
  belongs_to :user
  validates :slept_time, presence: true
  validates :wakeup_time, presence: true
  validate :dates_cannnot_be_registered_if_there_is_no_yesterdays_date, on: [:create]

  def dates_cannnot_be_registered_if_there_is_no_yesterdays_date
    return if date.present? && user.sleeps.blank?
    if date != Sleep.last.date.tomorrow
      errors.add(:date, "You can't register that there is no data about before days.")
    end
  end
end
