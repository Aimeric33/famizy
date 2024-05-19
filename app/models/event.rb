class Event < ApplicationRecord
  belongs_to :family

  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  def past?
    end_date < Time.now
  end

  def self.any_on?(date)
    where(start_date: (date.to_datetime...date.to_datetime.change(hour: 24))).any?
  end
end
