##
# Class: Base presenter
#
class BasePresenter
  API_HOST = 'http://localhost:3000'.freeze

  def prepare_hash
    @items.is_a?(Hash) ? prepare_error : prepare_data
  end

private

  def initialize(_params)
    @result = {
      links: {
        self: API_HOST
      }
    }
  end

  def prepare_error
    @result.merge!(error: error)
  end

  def prepare_data
    if @items.respond_to?('each')
      @result.merge!(data: [])
      @items.each do |item|
        @result[:data] << data(item)
      end
    else
      @result.merge!(data: data(@items))
    end
    @result
  end

  def data(item)
    {
      type: item.model_name.collection,
      id: item.id,
      attributes: item.attributes
    }
  end

  def error
    {
      status: @items[:status],
      title:  @items[:error]
    }
  end
end
