class List < ApplicationRecord
  belongs_to :family
  has_many :list_items, dependent: :destroy

  enum list_type: { groceries: 0, to_do: 1 }

  validates :name, presence: true, length: { minimum: 5, maximum: 50 }
  validates :list_type, presence: true
end
