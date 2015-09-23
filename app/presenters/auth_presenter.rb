##
# Class: Auth presenter
#
class AuthPresenter < BasePresenter
  def as_json(_options={})
    prepare_hash
  end

private

  def initialize(auth)
    @items = auth
    super
  end
end
