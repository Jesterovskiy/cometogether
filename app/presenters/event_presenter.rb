##
# Class: Event presenter
#
class EventPresenter
  def as_json(_options={})
    @item
  end

private

  def initialize(event)
    @item = event
  end
end
