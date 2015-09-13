##
# Class: Event presenter
#
class EventPresenter
  def as_json(options={})
    @item
  end

private

  def initialize(event)
    @item = event
  end
end
