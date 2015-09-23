require 'rails_helper'

RSpec.resource 'Events', type: :controller do
  include Helpers
  header 'Authorization', 'Token token=test123123'

  get '/api/v1/events' do
    context 'with valid params' do
      let!(:current_user) { Fabricate(:user, auth_token: 'test123123', role: 'admin') }
      let!(:events)       { Fabricate.times(3, :event) }

      example_request '(INDEX) Get all events' do
        expect(status).to be(200)
        expect(JSON.parse(response_body)['data']).to eq(events.map { |event| event_hash(event) })
      end
    end

    context 'with invalid token', document: nil do
      let!(:current_user) { Fabricate(:user, auth_token: 'test321321', role: 'admin') }
      let!(:events)       { Fabricate.times(3, :event) }

      example_request 'Get error message' do
        expect(status).to be(401)
        expect(JSON.parse(response_body)['error']).to eq(
          'status' => 401, 'title' => 'Token is wrong. Try again.'
        )
      end
    end
  end

  get '/api/v1/events/:id' do
    parameter :id, 'Event ID', type: 'Integer', required: true

    context 'with valid params' do
      let!(:current_user) { Fabricate(:user, auth_token: 'test123123', role: 'admin') }
      let(:event)         { Fabricate(:event) }
      let(:id)            { event.id }

      example_request '(SHOW) Get event' do
        expect(status).to be(200)
        expect(JSON.parse(response_body)['data']).to eq(event_hash(event))
      end
    end

    context 'with invalid params', document: nil do
      let!(:current_user) { Fabricate(:user, auth_token: 'test123123', role: 'admin') }
      let(:event)         { Fabricate(:event) }
      let(:id)            { 100_500 }

      example_request 'Get error message' do
        expect(status).to be(404)
        expect(JSON.parse(response_body)['error']).to eq(
          'status' => 404, 'title' => 'Resource not found'
        )
      end
    end
  end

  post '/api/v1/events' do
    parameter :name, 'Name', type: 'String', scope: :event, required: true
    parameter :description, 'Description', type: 'String', scope: :event
    parameter :location, 'Location', type: 'String', scope: :event
    parameter :date, 'Password', type: 'DateTime', scope: :event
    parameter :user_id, 'User ID', type: 'Integer', scope: :event

    context 'with valid params' do
      let(:name)        { FFaker::Lorem.word }
      let(:description) { FFaker::Lorem.phrase }
      let(:location)    { FFaker::Address.city }
      let(:date)        { FFaker::Time.date }
      let(:user_id)     { Fabricate(:user).id }

      let!(:current_user) { Fabricate(:user, auth_token: 'test123123', role: 'admin') }

      example_request '(CREATE) Create event' do
        expect(status).to be(200)
        expect(JSON.parse(response_body)['data']).to eq(event_hash(Event.last))
      end
    end

    context 'with invalid params', document: nil do
      let!(:current_user) { Fabricate(:user, auth_token: 'test123123', role: 'admin') }
      let(:description)   { FFaker::Lorem.phrase }

      example_request 'Get error message' do
        expect(status).to be(400)
        expect(JSON.parse(response_body)['error']).to eq(
          'status' => 400, 'title' => { 'name' => ["can't be blank"] }
        )
      end
    end
  end

  put '/api/v1/events/:id' do
    parameter :id, 'Event ID', type: 'Integer', required: true
    parameter :name, 'Name', type: 'String', scope: :event, required: true
    parameter :description, 'Description', type: 'String', scope: :event
    parameter :location, 'Location', type: 'String', scope: :event
    parameter :date, 'Password', type: 'DateTime', scope: :event
    parameter :user_id, 'User ID', type: 'Integer', scope: :event

    context 'with valid params' do
      let(:event)       { Fabricate(:event) }
      let(:id)          { event.id }
      let(:name)        { FFaker::Lorem.word }
      let(:description) { FFaker::Lorem.phrase }
      let(:location)    { FFaker::Address.city }
      let(:date)        { FFaker::Time.date }
      let(:user_id)     { Fabricate(:user).id }

      let!(:current_user) { Fabricate(:user, auth_token: 'test123123', role: 'admin') }

      example_request '(UPDATE) Update event' do
        expect(status).to be(200)
        expect(JSON.parse(response_body)['data']).to eq(event_hash(Event.last))
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

  delete '/api/v1/events/:id' do
    parameter :id, 'Event ID', type: 'Integer', required: true

    context 'with valid params' do
      let(:event) { Fabricate(:event) }
      let(:id)    { event.id }

      let!(:current_user) { Fabricate(:user, auth_token: 'test123123', role: 'admin') }

      example_request '(DELETE) Delete event' do
        expect(status).to be(200)
        expect(Event.count).to be(0)
        expect(JSON.parse(response_body)['data']).to eq(event_hash(event))
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
