##
# Class: Items List presenter
#
class ItemsListPresenter
  def as_json(options={})
    @items
  end

private

  def initialize
    @items = Item.all
  end
end
