class Family < ApplicationRecord
  has_many :family_members, dependent: :destroy
  has_many :users, through: :family_members

  validates :name, presence: true, length: { minimum: 5, maximum: 40 }
end
