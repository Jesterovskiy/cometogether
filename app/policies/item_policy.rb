class ItemPolicy
  attr_reader :user, :item

  def initialize(user, item)
    @user = user
    @item = item
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
