class Event < ApplicationRecord
  belongs_to :family

  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  extend FriendlyId
  friendly_id :name, use: :scoped, scope: :family

  def should_generate_new_friendly_id?
    name_changed? || super
  end

  def past?
    end_date < Time.now
  end

  def self.any_on?(date)
    where(start_date: (date.to_datetime...date.to_datetime.change(hour: 24))).any?
  end

  def self.events_this_week(family)
    where(family: family, start_date: (Date.today.beginning_of_week..Date.today.end_of_week))
  end
end
