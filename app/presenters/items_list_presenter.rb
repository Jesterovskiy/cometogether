##
# Class: Items List presenter
#
class ItemsListPresenter
  def as_json(_options={})
    @items
  end

private

  def initialize
    @items = Item.all
  end
end
