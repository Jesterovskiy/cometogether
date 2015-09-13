##
# Class: Item presenter
#
class ItemPresenter
  def as_json(options={})
    @item
  end

private

  def initialize(item)
    @item = item
  end
end
