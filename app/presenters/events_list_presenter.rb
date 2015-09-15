##
# Class: Events List presenter
#
class EventsListPresenter
  def as_json(_options={})
    @items
  end

private

  def initialize
    @items = Event.all
  end
end
