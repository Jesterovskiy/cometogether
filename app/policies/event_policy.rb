class EventPolicy
  attr_reader :user, :event

  def initialize(user, event)
    @user = user
    @event = event
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    false
  end

  def update?
    false
  end

  def destroy?
    false
  end
end
