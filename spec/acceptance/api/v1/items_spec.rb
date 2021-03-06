require 'rails_helper'

RSpec.resource 'Items' do
  include Helpers
  header 'Authorization', 'Token token=test123123'

  get '/api/v1/items' do
    context 'with valid params' do
      let!(:current_user) { Fabricate(:user, auth_token: 'test123123', role: 'admin') }
      let!(:items)        { Fabricate.times(3, :item) }

      example_request '(INDEX) Get all items' do
        expect(status).to be(200)
        expect(JSON.parse(response_body)['data']).to eq(items.map { |item| item_hash(item) })
      end
    end

    context 'with invalid token', document: nil do
      let!(:current_user) { Fabricate(:user, auth_token: 'test321321', role: 'admin') }
      let!(:items)        { Fabricate.times(3, :item) }

      example_request 'Get error message' do
        expect(status).to be(401)
        expect(JSON.parse(response_body)['error']).to eq(
          'status' => 401, 'title' => 'Token is wrong. Try again.'
        )
      end
    end
  end

  get '/api/v1/items/:id' do
    parameter :id, 'Item ID', type: 'Integer', required: true

    context 'with valid params' do
      let!(:current_user) { Fabricate(:user, auth_token: 'test123123', role: 'admin') }
      let(:item) { Fabricate(:item) }
      let(:id)   { item.id }

      example_request '(SHOW) Get item' do
        expect(status).to be(200)
        expect(JSON.parse(response_body)['data']).to eq(item_hash(item))
      end
    end

    context 'with invalid params', document: nil do
      let!(:current_user) { Fabricate(:user, auth_token: 'test123123', role: 'admin') }
      let(:item) { Fabricate(:item) }
      let(:id)   { 100_500 }

      example_request 'Get error message' do
        expect(status).to be(404)
        expect(JSON.parse(response_body)['error']).to eq(
          'status' => 404, 'title' => 'Resource not found'
        )
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

      let!(:current_user) { Fabricate(:user, auth_token: 'test123123', role: 'admin') }

      example_request '(CREATE) Create item' do
        expect(status).to be(200)
        expect(JSON.parse(response_body)['data']).to eq(item_hash(Item.last))
      end
    end

    context 'with invalid params', document: nil do
      let!(:current_user) { Fabricate(:user, auth_token: 'test123123', role: 'admin') }
      let(:comment) { FFaker::Name.last_name }

      example_request 'Get error message' do
        expect(status).to be(400)
        expect(JSON.parse(response_body)['error']).to eq(
          'status' => 400, 'title' => { 'description' => ["can't be blank"] }
        )
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

      let!(:current_user) { Fabricate(:user, auth_token: 'test123123', role: 'admin') }

      example_request '(UPDATE) Update item' do
        expect(status).to be(200)
        expect(JSON.parse(response_body)['data']).to eq(item_hash(Item.last))
      end
    end

    context 'with invalid params', document: nil do
      let!(:current_user) { Fabricate(:user, auth_token: 'test123123', role: 'admin') }
      let(:id) { 100_500 }

      example_request 'Get error message' do
        expect(status).to be(404)
        expect(JSON.parse(response_body)['error']).to eq(
          'status' => 404, 'title' => 'Resource not found'
        )
      end
    end
  end

  delete '/api/v1/items/:id' do
    parameter :id, 'Item ID', type: 'Integer', required: true

    context 'with valid params' do
      let(:item) { Fabricate(:item) }
      let(:id)   { item.id }

      let!(:current_user) { Fabricate(:user, auth_token: 'test123123', role: 'admin') }

      example_request '(DELETE) Delete item' do
        expect(status).to be(200)
        expect(Item.count).to be(0)
        expect(JSON.parse(response_body)['data']).to eq(item_hash(item))
      end
    end

    context 'with invalid params', document: nil do
      let!(:current_user) { Fabricate(:user, auth_token: 'test123123', role: 'admin') }
      let(:id) { 100_500 }

      example_request 'Get error message' do
        expect(status).to be(404)
        expect(JSON.parse(response_body)['error']).to eq(
          'status' => 404, 'title' => 'Resource not found'
        )
      end
    end
  end
end
