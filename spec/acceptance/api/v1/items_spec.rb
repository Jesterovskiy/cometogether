require 'rails_helper'

RSpec.resource 'Items' do
  get '/api/v1/items' do
    context 'with valid params' do
      let!(:items) { Fabricate.times(3, :item) }

      example_request 'Get items list' do
        expect(status).to be(200)
        expect(response_body).to eq(items.to_json)
      end
    end
  end

  get '/api/v1/items/:id' do
    parameter :id, 'Item ID', type: 'Integer', required: true

    context 'with valid params' do
      let(:item) { Fabricate(:item) }
      let(:id)   { item.id }

      example_request 'Get item attributes' do
        expect(status).to be(200)
        expect(response_body).to eq(item.to_json)
      end
    end

    context 'with invalid params' do
      let(:item) { Fabricate(:item) }
      let(:id)   { 100_500 }

      example_request 'Get error message' do
        expect(status).to be(404)
        expect(response_body).to eq({ message: 'Resource not found' }.to_json)
      end
    end
  end

  post '/api/v1/items' do
    parameter :description, 'Description of item', type: 'String', scope: :item, required: true
    parameter :comment, 'Comment about item', type: 'String', scope: :item
    parameter :event_id, 'Event ID', type: 'Integer', scope: :item

    context 'with valid params' do
      let(:description) { FFaker::Name.first_name }
      let(:comment)     { FFaker::Name.last_name }
      let(:event_id)    { Fabricate(:event).id }

      example_request 'Get item attributes' do
        expect(status).to be(200)
        expect(response_body).to eq(Item.last.to_json)
      end
    end

    context 'with invalid params' do
      let(:comment) { FFaker::Name.last_name }

      example_request 'Get error message' do
        expect(status).to be(400)
        expect(response_body).to eq({ message: { description: ["can't be blank"] } }.to_json)
      end
    end
  end

  put '/api/v1/items/:id' do
    parameter :id, 'Item ID', type: 'Integer', required: true
    parameter :description, 'Description of item', type: 'String', scope: :item, required: true
    parameter :comment, 'Comment about item', type: 'String', scope: :item
    parameter :event_id, 'Event ID', type: 'Integer', scope: :item

    context 'with valid params' do
      let(:item)        { Fabricate(:item) }
      let(:id)          { item.id }
      let(:description) { FFaker::Name.first_name }
      let(:comment)     { FFaker::Name.last_name }
      let(:event_id)    { Fabricate(:event).id }

      example_request 'Update item attributes' do
        expect(status).to be(200)
        expect(response_body).to eq(Item.last.to_json)
      end
    end

    context 'with invalid params' do
      let(:id) { 100_500 }

      example_request 'Get error message' do
        expect(status).to be(404)
        expect(response_body).to eq({ message: 'Resource not found' }.to_json)
      end
    end
  end

  delete '/api/v1/items/:id' do
    parameter :id, 'Item ID', type: 'Integer', required: true

    context 'with valid params' do
      let(:item) { Fabricate(:item) }
      let(:id)   { item.id }

      example_request 'Get message' do
        expect(status).to be(200)
        expect(Item.count).to be(0)
        expect(response_body).to eq({ message: 'Resource deleted' }.to_json)
      end
    end

    context 'with invalid params' do
      let(:id) { 100_500 }

      example_request 'Get error message' do
        expect(status).to be(404)
        expect(response_body).to eq({ message: 'Resource not found' }.to_json)
      end
    end
  end
end
