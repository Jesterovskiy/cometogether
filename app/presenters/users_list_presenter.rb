##
# Class: Users List presenter
#
class UsersListPresenter < BasePresenter
  def as_json(_options={})
    prepare_hash
  end

private

  def initialize(users)
    @items = users
    super
  end
end
