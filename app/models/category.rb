class Category < ApplicationRecord
  belongs_to :categorizable, polymorphic: true

  validates :name, presence: true
end
