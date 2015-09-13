##
# Class: User presenter
#
class UserPresenter
  def as_json(options={})
    @item
  end

private

  def initialize(user)
    @item = user
  end
end
