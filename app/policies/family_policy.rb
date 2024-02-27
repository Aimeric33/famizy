class FamilyPolicy < ApplicationPolicy
  def create?
    true
  end

  def new?
    create?
  end

  def show?
    user.families.include?(record)
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

  def invite?
    show?
  end

  class Scope < Scope
    def resolve
      scope.where(id: user.families)
    end
  end
end
