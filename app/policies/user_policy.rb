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
    current_user.is?(:admin) or current_user == user
  end

  def update?
    current_user.is?(:admin) or current_user == user
  end

  def destroy?
    current_user.is?(:admin) or current_user == user
  end
end
