##
# Class: Users List presenter
#
class UsersListPresenter
  def as_json(options={})
    @items
  end

private

  def initialize
    @items = User.all
  end
end
