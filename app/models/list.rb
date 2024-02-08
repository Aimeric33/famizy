class List < ApplicationRecord
  belongs_to :family
  has_many :list_items, dependent: :destroy

  validates :name, presence: true, length: { minimum: 5, maximum: 50 }
  validates :type, presence: true, inclusion: { in: %w(groceries to_do) }
end
