require 'rails_helper'

RSpec.resource 'Users', :type => :controller do
  header 'Accept', 'application/json'

  post '/api/v1/users/sign_in' do
    parameter :email, 'Email', type: 'String', scope: :user, required: true
    parameter :password, 'Password', type: 'String', scope: :user, required: true

    context 'with valid params' do
      let(:user)     { Fabricate(:user) }
      let(:email)    { user.email }
      let(:password) { user.password }

      example_request 'Get auth token' do
        expect(status).to be(200)
        expect(response_body).to eq({ message: 'Your auth token is ' + user.auth_token }.to_json)
      end
    end

    context 'with invalid params' do
      let(:user)     { Fabricate(:user) }
      let(:email)    { 'BlahBlah@gmail.com' }
      let(:password) { 'IDontKnow' }

      example_request 'Get error message' do
        expect(status).to be(401)
        expect(response_body).to eq({
          message: 'Email or password is wrong. Try again.'
        }.to_json)
      end
    end
  end

  get '/api/v1/users' do
    header 'Authorization', 'Token token=test123123'

    context 'with valid params' do
      let!(:current_user) { Fabricate(:user, auth_token: 'test123123', role: 'admin') }
      let!(:users) { Fabricate.times(3, :user) }

      example_request 'Get users list' do
        expect(status).to be(200)
        expect(response_body).to eq(([current_user] + users).to_json)
      end
    end
  end

  get '/api/v1/users/:id' do
    header 'Authorization', 'Token token=test123123'
    parameter :id, 'User ID', type: 'Integer', required: true

    context 'with valid params' do
      context 'when user admin' do
        let!(:current_user) { Fabricate(:user, auth_token: 'test123123', role: 'admin') }
        let(:user) { Fabricate(:user) }
        let(:id)   { user.id }

        example_request 'Get user attributes' do
          expect(status).to be(200)
          expect(response_body).to eq(user.to_json)
        end
      end

      context 'when user is current_user' do
        let(:user) { Fabricate(:user, auth_token: 'test123123', role: 'user') }
        let(:id)   { user.id }

        example_request 'Get user attributes' do
          expect(status).to be(200)
          expect(response_body).to eq(user.to_json)
        end
      end
    end

    context 'with invalid params' do
      let!(:current_user) { Fabricate(:user, auth_token: 'test123123', role: 'admin') }
      let(:id)            { 100_500 }

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
      let(:role)       { User::ROLES.sample }

      example_request 'Create user' do
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
          { password: ["can't be blank", "can't be blank"],
            email: ["can't be blank"], role: [' is not a valid role'] }
        }.to_json)
      end
    end
  end

  put '/api/v1/users/:id' do
    header 'Authorization', 'Token token=test123123'
    parameter :id, 'User ID', type: 'Integer', required: true
    parameter :first_name, 'First name', type: 'String', scope: :user
    parameter :last_name, 'Last name', type: 'String', scope: :user
    parameter :email, 'Email', type: 'String', scope: :user, required: true
    parameter :password, 'Password', type: 'String', scope: :user, required: true
    parameter :role, 'Role', type: 'String', scope: :user

    context 'with valid params' do
      context 'when user admin' do
        let!(:current_user) { Fabricate(:user, auth_token: 'test123123', role: 'admin') }
        let(:user)       { Fabricate(:user) }
        let(:id)         { user.id }
        let(:first_name) { FFaker::Name.first_name }
        let(:last_name)  { FFaker::Name.last_name }
        let(:email)      { FFaker::Internet.email }
        let(:password)   { FFaker::Internet.password }
        let(:role)       { User::ROLES.sample }

        example_request 'Update user attributes' do
          expect(status).to be(200)
          expect(response_body).to eq(User.last.to_json)
        end
      end

      context 'when user is current_user' do
        let(:user)       { Fabricate(:user, auth_token: 'test123123', role: 'user') }
        let(:id)         { user.id }
        let(:first_name) { FFaker::Name.first_name }
        let(:last_name)  { FFaker::Name.last_name }
        let(:email)      { FFaker::Internet.email }
        let(:password)   { FFaker::Internet.password }
        let(:role)       { User::ROLES.sample }

        example_request 'Update user attributes' do
          expect(status).to be(200)
          expect(response_body).to eq(User.last.to_json)
        end
      end
    end

    context 'with invalid params' do
      let!(:current_user) { Fabricate(:user, auth_token: 'test123123', role: 'admin') }
      let(:id) { 100_500 }

      example_request 'Get error message' do
        expect(status).to be(404)
        expect(response_body).to eq({ message: 'Resource not found' }.to_json)
      end
    end
  end

  delete '/api/v1/users/:id' do
    header 'Authorization', 'Token token=test123123'
    parameter :id, 'User ID', type: 'Integer', required: true

    context 'with valid params' do
      context 'when user admin' do
        let!(:current_user) { Fabricate(:user, auth_token: 'test123123', role: 'admin') }
        let(:user) { Fabricate(:user) }
        let(:id)   { user.id }

        example_request 'Get message' do
          expect(status).to be(200)
          expect(User.count).to be(1)
          expect(response_body).to eq({ message: 'Resource deleted' }.to_json)
        end
      end

      context 'when user is current_user' do
        let(:user) { Fabricate(:user, auth_token: 'test123123', role: 'user') }
        let(:id)   { user.id }

        example_request 'Get message' do
          expect(status).to be(200)
          expect(User.count).to be(0)
          expect(response_body).to eq({ message: 'Resource deleted' }.to_json)
        end
      end
    end

    context 'with invalid params' do
      let!(:current_user) { Fabricate(:user, auth_token: 'test123123', role: 'admin') }
      let(:id) { 100_500 }

      example_request 'Get error message' do
        expect(status).to be(404)
        expect(response_body).to eq({ message: 'Resource not found' }.to_json)
      end
    end
  end
end
