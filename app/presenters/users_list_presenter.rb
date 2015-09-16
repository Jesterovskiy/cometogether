##
# Class: Users List presenter
#
class UsersListPresenter
  def as_json(_options={})
    @items
  end

private

  def initialize(users)
    @items = users
  end
end
