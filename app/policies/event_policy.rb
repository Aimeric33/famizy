class EventPolicy < ApplicationPolicy
  def create?
    user.families.include?(record.family)
  end

  def new?
    create?
  end

  class Scope < Scope
    def resolve
      scope.where(family_id: user.families)
    end
  end
end
