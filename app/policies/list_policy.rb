class ListPolicy < ApplicationPolicy
  def show?
    user.families.include?(record.family)
  end

  def create?
    user.families.include?(params[:family_id])
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
