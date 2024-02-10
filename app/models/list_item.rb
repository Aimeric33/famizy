class ListItem < ApplicationRecord
  belongs_to :list

  def done!
    update(done: true)
  end

  def undone!
    update(done: false)
  end
end
