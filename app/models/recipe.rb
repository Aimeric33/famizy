class Recipe < ApplicationRecord
  belongs_to :family
  enum meal_type: { starter: 0, main_course: 1, dessert: 2 }
  has_many :ingredients, dependent: :destroy
  has_many :categories, as: :categorizable, dependent: :destroy

  has_one_attached :photo, dependent: :purge

  validates :name, presence: true
  validates :meal_type, presence: true
  validates :photo, content_type: ['image/jpg', 'image/jpeg', 'image/webp'], size: { less_than: 5.megabytes }

  accepts_nested_attributes_for :ingredients, reject_if: ->(attributes) { attributes['name'].blank? }, allow_destroy: true
end
