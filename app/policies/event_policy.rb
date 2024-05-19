class EventPolicy < ApplicationPolicy
  def show?
    user.families.include?(record.family)
  end

  def create?
    show?
  end

  def new?
    create?
  end

  def update?
    show?
  end

  def edit?
    update?
  end

  def destroy?
    show?
  end

  class Scope < Scope
    def resolve
      scope.where(family_id: user.families)
    end
  end
end
