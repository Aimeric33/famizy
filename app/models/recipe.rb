class Recipe < ApplicationRecord
  belongs_to :family
  has_many :categories, as: :categorizable

  validates :name, presence: true
end
