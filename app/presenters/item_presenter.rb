##
# Class: Item presenter
#
class ItemPresenter < BasePresenter
  def as_json(_options={})
    prepare_hash
  end

private

  def initialize(item)
    @items = item
    super
  end
end
