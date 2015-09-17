class EventPolicy
  attr_reader :user, :event

  def initialize(user, event)
    @user = user
    @event = event
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.is?(:admin) || user.is?(:user)
  end

  def update?
    user.is?(:admin) || event.user == user && !user.is?(:guest)
  end

  def destroy?
    user.is?(:admin) || event.user == user && !user.is?(:guest)
  end
end
