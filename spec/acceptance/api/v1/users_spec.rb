require 'rails_helper'

RSpec.resource 'Users' do
  get '/api/v1/users' do
    context 'with valid params' do
      let!(:users) { Fabricate.times(3, :user) }

      example_request 'Get users list' do
        expect(status).to be(200)
        expect(response_body).to eq(users.to_json)
      end
    end
  end

  get '/api/v1/users/:id' do
    parameter :id, 'User ID', type: 'Integer', required: true

    context 'with valid params' do
      let(:user) { Fabricate(:user) }
      let(:id)   { user.id }

      example_request 'Get user attributes' do
        expect(status).to be(200)
        expect(response_body).to eq(user.to_json)
      end
    end

    context 'with invalid params' do
      let(:user) { Fabricate(:user) }
      let(:id)   { 100_500 }

      example_request 'Get error message' do
        expect(status).to be(404)
        expect(response_body).to eq({ message: 'Resource not found' }.to_json)
      end
    end
  end

  post '/api/v1/users' do
    parameter :first_name, 'First name', type: 'String', scope: :user
    parameter :last_name, 'Last name', type: 'String', scope: :user
    parameter :email, 'Email', type: 'String', scope: :user, required: true
    parameter :password, 'Password', type: 'String', scope: :user, required: true
    parameter :role, 'Role', type: 'String', scope: :user

    context 'with valid params' do
      let(:first_name) { FFaker::Name.first_name }
      let(:last_name)  { FFaker::Name.last_name }
      let(:email)      { FFaker::Internet.email }
      let(:password)   { FFaker::Internet.password }
      let(:role)       { FFaker::Lorem.word }

      example_request 'Get user attributes' do
        expect(status).to be(200)
        expect(response_body).to eq(User.last.to_json)
      end
    end

    context 'with invalid params' do
      let(:first_name) { FFaker::Name.first_name }
      let(:last_name)  { FFaker::Name.last_name }

      example_request 'Get error message' do
        expect(status).to be(400)
        expect(response_body).to eq({ message:
          { email: ["can't be blank"], password: ["can't be blank"] }
        }.to_json)
      end
    end
  end

  put '/api/v1/users/:id' do
    parameter :id, 'User ID', type: 'Integer', required: true
    parameter :first_name, 'First name', type: 'String', scope: :user
    parameter :last_name, 'Last name', type: 'String', scope: :user
    parameter :email, 'Email', type: 'String', scope: :user, required: true
    parameter :password, 'Password', type: 'String', scope: :user, required: true
    parameter :role, 'Role', type: 'String', scope: :user

    context 'with valid params' do
      let(:user)       { Fabricate(:user) }
      let(:id)         { user.id }
      let(:first_name) { FFaker::Name.first_name }
      let(:last_name)  { FFaker::Name.last_name }
      let(:email)      { FFaker::Internet.email }
      let(:password)   { FFaker::Internet.password }
      let(:role)       { FFaker::Lorem.word }

      example_request 'Update user attributes' do
        expect(status).to be(200)
        expect(response_body).to eq(User.last.to_json)
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

  delete '/api/v1/users/:id' do
    parameter :id, 'User ID', type: 'Integer', required: true

    context 'with valid params' do
      let(:user) { Fabricate(:user) }
      let(:id)   { user.id }

      example_request 'Get message' do
        expect(status).to be(200)
        expect(User.count).to be(0)
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
