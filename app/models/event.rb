class Event < ApplicationRecord
  belongs_to :family

  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  def past?
    end_date < Time.now
  end
end
