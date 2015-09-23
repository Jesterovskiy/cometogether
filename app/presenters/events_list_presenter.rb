##
# Class: Events List presenter
#
class EventsListPresenter < BasePresenter
  def as_json(_options={})
    prepare_hash
  end

private

  def initialize(events)
    @items = events
    super
  end
end
