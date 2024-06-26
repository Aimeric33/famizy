class Recipe < ApplicationRecord
  belongs_to :family
  enum recipe_type: { starter: 0, main_course: 1, dessert: 2 }
  has_many :ingredients, dependent: :destroy
  has_many :categories, as: :categorizable, dependent: :destroy
  has_many :meals, dependent: :destroy

  has_one_attached :photo, dependent: :purge

  validates :name, presence: true
  validates :recipe_type, presence: true
  validates :photo, content_type: ['image/jpg', 'image/jpeg', 'image/webp'], size: { less_than: 5.megabytes }

  accepts_nested_attributes_for :ingredients, reject_if: ->(attributes) { attributes['name'].blank? }, allow_destroy: true

  extend FriendlyId
  friendly_id :name, use: :scoped, scope: :family

  def should_generate_new_friendly_id?
    name_changed? || super
  end

  def self.filters
    [
      [I18n.t('recipes.index.filters.all'), 'all'],
      [I18n.t('recipes.index.filters.starter'), 'starter'],
      [I18n.t('recipes.index.filters.main_course'), 'main_course'],
      [I18n.t('recipes.index.filters.dessert'), 'dessert']
    ]
  end
end
