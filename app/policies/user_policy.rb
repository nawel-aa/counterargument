class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    return true
  end

  def create?
    return true
  end

  def edit?
    return true
  end

  def update?
    user == record
  end

  def destroy?
    user == record
  end
end
