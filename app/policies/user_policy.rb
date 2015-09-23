##
# Class: Auth policy for User
#
class UserPolicy
  attr_reader :current_user, :user

  def initialize(current_user, user)
    @current_user = current_user
    @user = user
  end

  def index?
    current_user.is?(:admin)
  end

  def show?
    current_user.is?(:admin) || current_user == user
  end

  def update?
    current_user.is?(:admin) || current_user == user && !user.is?(:guest)
  end

  def destroy?
    current_user.is?(:admin) || current_user == user && !user.is?(:guest)
  end
end
