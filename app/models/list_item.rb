class ListItem < ApplicationRecord
  belongs_to :list

  validates :name, presence: true

  def done!
    update(done: true)
  end

  def undone!
    update(done: false)
  end
end
