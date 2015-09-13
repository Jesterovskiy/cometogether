require 'rails_helper'

RSpec.resource 'Events' do
  get '/api/v1/events' do
    context 'with valid params' do
      let!(:events) { Fabricate.times(3, :event) }

      example_request 'Get events list' do
        expect(status).to be(200)
        expect(response_body).to eq(events.to_json)
      end
    end
  end

  get '/api/v1/events/:id' do
    parameter :id, 'Event ID', type: 'Integer', required: true

    context 'with valid params' do
      let(:event) { Fabricate(:event) }
      let(:id)    { event.id }

      example_request 'Get event attributes' do
        expect(status).to be(200)
        expect(response_body).to eq(event.to_json)
      end
    end

    context 'with invalid params' do
      let(:event) { Fabricate(:event) }
      let(:id)    { 100_500 }

      example_request 'Get error message' do
        expect(status).to be(404)
        expect(response_body).to eq({message:'Resource not found'}.to_json)
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

      example_request 'Get event attributes' do
        expect(status).to be(200)
        expect(response_body).to eq(Event.last.to_json)
      end
    end

    context 'with invalid params' do
      let(:description) { FFaker::Lorem.phrase }

      example_request 'Get error message' do
        expect(status).to be(400)
        expect(response_body).to eq({ message: { name:["can't be blank"] }}.to_json)
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
      let(:event)      { Fabricate(:event) }
      let(:id)         { event.id }
      let(:name)        { FFaker::Lorem.word }
      let(:description) { FFaker::Lorem.phrase }
      let(:location)    { FFaker::Address.city }
      let(:date)        { FFaker::Time.date }
      let(:user_id)     { Fabricate(:user).id }

      example_request 'Update event attributes' do
        expect(status).to be(200)
        expect(response_body).to eq(Event.last.to_json)
      end
    end

    context 'with invalid params' do
      let(:id) { 100500 }

      example_request 'Get error message' do
        expect(status).to be(404)
        expect(response_body).to eq({message:'Resource not found'}.to_json)
      end
    end
  end

  delete '/api/v1/events/:id' do
    parameter :id, 'Event ID', type: 'Integer', required: true

    context 'with valid params' do
      let(:event) { Fabricate(:event) }
      let(:id)    { event.id }

      example_request 'Get message' do
        expect(status).to be(200)
        expect(Event.count).to be(0)
        expect(response_body).to eq({message:'Resource deleted'}.to_json)
      end
    end

    context 'with invalid params' do
      let(:id) { 100500 }

      example_request 'Get error message' do
        expect(status).to be(404)
        expect(response_body).to eq({message:'Resource not found'}.to_json)
      end
    end
  end
end
