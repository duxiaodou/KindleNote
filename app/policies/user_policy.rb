class UserPolicy < ApplicationPolicy
  def show?
    scope.where(:id => record.id).exists? && (user.id == record.id || user.has_role?(:admin) )
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
