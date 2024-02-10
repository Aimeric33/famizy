class ListItemPolicy < ApplicationPolicy
  def create?
    user.families.include?(record.list.family)
  end

  class Scope < Scope
  end
end
