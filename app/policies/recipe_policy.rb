class RecipePolicy < ApplicationPolicy
  def show?
    user.families.include?(record.family)
  end

  def create?
    user.families.include?(record.family)
  end

  def new?
    create?
  end

  def update?
    user.families.include?(record.family)
  end

  def edit?
    update?
  end

  def destroy?
    user.families.include?(record.family)
  end

  class Scope < Scope
    def resolve
      scope.where(family_id: user.families)
    end
  end
end
