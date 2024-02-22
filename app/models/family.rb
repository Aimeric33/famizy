class Family < ApplicationRecord
  has_many :family_members, dependent: :destroy
  has_many :users, through: :family_members
  has_many :lists, dependent: :destroy

  validates :name, presence: true, length: { minimum: 5, maximum: 50 }
  validates :description, presence: true, length: { maximum: 250 }
end
