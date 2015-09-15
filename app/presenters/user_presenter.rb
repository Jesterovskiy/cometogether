##
# Class: User presenter
#
class UserPresenter
  def as_json(_options={})
    @item
  end

private

  def initialize(user)
    @item = user
  end
end
