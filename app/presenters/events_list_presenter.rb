##
# Class: Events List presenter
#
class EventsListPresenter
  def as_json(_options={})
    @items
  end

private

  def initialize(events)
    @items = events
  end
end
