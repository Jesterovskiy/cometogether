##
# Class: User presenter
#
class UserPresenter < BasePresenter
  def as_json(_options={})
    prepare_hash
  end

private

  def initialize(user)
    @items = user
    super
  end
end
