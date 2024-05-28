class Family < ApplicationRecord
  has_many :family_members, dependent: :destroy
  has_many :users, through: :family_members
  has_many :lists, dependent: :destroy
  has_many :meals, dependent: :destroy
  has_many :recipes, dependent: :destroy
  has_many :events, dependent: :destroy

  validates :name, presence: true, length: { minimum: 5, maximum: 50 }
  validates :description, length: { maximum: 250 }

  extend FriendlyId
  friendly_id :name

  def should_generate_new_friendly_id?
    name_changed? || super
  end
end
