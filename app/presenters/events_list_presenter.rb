##
# Class: Events List presenter
#
class EventsListPresenter
  def as_json(options={})
    @items
  end

private

  def initialize
    @items = Event.all
  end
end
