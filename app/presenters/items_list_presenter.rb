##
# Class: Items List presenter
#
class ItemsListPresenter < BasePresenter
  def as_json(_options={})
    prepare_hash
  end

private

  def initialize(items)
    @items = items
    super
  end
end
