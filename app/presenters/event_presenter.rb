##
# Class: Event presenter
#
class EventPresenter < BasePresenter
  def as_json(_options={})
    prepare_hash
  end

private

  def initialize(event)
    @items = event
    super
  end
end
