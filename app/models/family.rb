class Family < ApplicationRecord
  has_many :family_members, dependent: :destroy

  validates :name, presence: true, length: { minimum: 5, maximum: 40 }
end
