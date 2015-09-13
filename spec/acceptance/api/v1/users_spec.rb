require 'rails_helper'

RSpec.resource 'Users' do
  get '/api/v1/users' do
    context 'with valid params' do
      let(:users) { Fabricate.times(3, :user) }

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
  end

  post '/api/v1/users' do
    parameter :first_name, 'First name', type: 'String'
    parameter :last_name, 'Last name', type: 'String'
    parameter :email, 'Email', type: 'String', required: true
    parameter :password, 'Password', type: 'String', required: true

    context 'with valid params' do
      let(:first_name) { FFaker::Name.first_name }
      let(:last_name)  { FFaker::Name.last_name }
      let(:email)      { FFaker::Internet.email }
      let(:password)   { FFaker::Internet.password }

      example_request 'Get user attributes' do
        expect(status).to be(200)
        expect(response_body).to eq(User.last.to_json)
      end
    end
  end

  put '/api/v1/users/:id' do
    parameter :id, 'User ID', type: 'Integer', required: true
    parameter :first_name, 'First name', type: 'String'
    parameter :last_name, 'Last name', type: 'String'
    parameter :email, 'Email', type: 'String', required: true
    parameter :password, 'Password', type: 'String', required: true

    context 'with valid params' do
      let(:first_name) { FFaker::Name.first_name }
      let(:last_name)  { FFaker::Name.last_name }
      let(:email)      { FFaker::Internet.email }
      let(:password)   { FFaker::Internet.password }

      example_request 'Update user attributes' do
        expect(status).to be(200)
        expect(response_body).to eq(User.last.to_json)
      end
    end
  end

  delete '/api/v1/users/:id' do
    parameter :id, 'User ID', type: 'Integer', required: true

    context 'with valid params' do
      let(:user) { Fabricate(:user) }
      let(:id)   { user.id }

      example_request 'Get user attributes' do
        expect(status).to be(200)
        expect(response_body).to eq(user.to_json)
      end
    end
  end
end
