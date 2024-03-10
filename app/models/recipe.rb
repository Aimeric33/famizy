class Recipe < ApplicationRecord
  belongs_to :family
  has_many :categories, as: :categorizable, dependent: :destroy

  has_one_attached :photo, dependent: :purge

  validates :name, presence: true
  validates :photo, content_type: ['image/jpg', 'image/jpeg', 'image/webp'], size: { less_than: 5.megabytes }
end
