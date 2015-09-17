##
# Class: Auth policy for Item
#
class ItemPolicy
  attr_reader :user, :item

  def initialize(user, item)
    @user = user
    @item = item
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
    user.is?(:admin) || item.event.user == user && !user.is?(:guest)
  end

  def destroy?
    user.is?(:admin) || item.event.user == user && !user.is?(:guest)
  end
end
