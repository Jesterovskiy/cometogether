require 'rails_helper'

RSpec.resource 'Users' do
  include Helpers
  header 'Accept', 'application/json'

  post '/api/v1/users/sign_in' do
    parameter :email, 'Email', type: 'String', scope: :user, required: true
    parameter :password, 'Password', type: 'String', scope: :user, required: true

    context 'with valid params' do
      let(:user)     { Fabricate(:user) }
      let(:email)    { user.email }
      let(:password) { user.password }

      example_request '(SIGN_IN) Get auth token' do
        expect(status).to be(200)
        expect(JSON.parse(response_body)['data']).to eq(user_hash(user))
      end
    end

    context 'with invalid params', document: nil do
      let(:user)     { Fabricate(:user) }
      let(:email)    { 'BlahBlah@gmail.com' }
      let(:password) { 'IDontKnow' }

      example_request 'Get error message' do
        expect(status).to be(401)
        expect(JSON.parse(response_body)['error']).to eq({
          'status' => 401, 'title' => 'Email or password is wrong. Try again.'
        })
      end
    end
  end

  get '/api/v1/users' do
    header 'Authorization', 'Token token=test123123'

    context 'with valid params' do
      let!(:current_user) { Fabricate(:user, auth_token: 'test123123', role: 'admin') }
      let!(:users)        { Fabricate.times(3, :user) }

      example_request '(INDEX) Get all users' do
        expect(status).to be(200)
        expect(JSON.parse(response_body)['data']).to eq(
          ([current_user] + users).map { |user| user_hash(user) }
        )
      end
    end

    context 'with invalid token', document: nil do
      let!(:current_user) { Fabricate(:user, auth_token: 'test321321', role: 'admin') }
      let!(:users)        { Fabricate.times(3, :user) }

      example_request 'Get error message' do
        expect(status).to be(401)
        expect(JSON.parse(response_body)['error']).to eq({
          'status' => 401, 'title' => 'Token is wrong. Try again.'
        })
      end
    end
  end

  get '/api/v1/users/:id' do
    header 'Authorization', 'Token token=test123123'
    parameter :id, 'User ID', type: 'Integer', required: true

    context 'with valid params' do
      let!(:current_user) { Fabricate(:user, auth_token: 'test123123', role: 'admin') }
      let(:user)          { Fabricate(:user) }
      let(:id)            { user.id }

      example_request '(SHOW) Get user' do
        expect(status).to be(200)
        expect(JSON.parse(response_body)['data']).to eq(user_hash(user))
      end
    end

    context 'with invalid params', document: nil do
      let!(:current_user) { Fabricate(:user, auth_token: 'test123123', role: 'admin') }
      let(:id)            { 100_500 }

      example_request 'Get error message' do
        expect(status).to be(404)
        expect(JSON.parse(response_body)['error']).to eq({
          'status' => 404, 'title' => 'Resource not found'
        })
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

      example_request '(CREATE) Create user' do
        expect(status).to be(200)
        expect(JSON.parse(response_body)['data']).to eq(user_hash(User.last))
      end
    end

    context 'with invalid params', document: nil do
      let(:first_name) { FFaker::Name.first_name }
      let(:last_name)  { FFaker::Name.last_name }

      example_request 'Get error message' do
        expect(status).to be(400)
        expect(JSON.parse(response_body)['error']).to eq({
          'status' => 400, 'title' => {
            'password' => ["can't be blank", "can't be blank"],
            'email' => ["can't be blank"], 'role' => [' is not a valid role']
          }
        })
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
      let(:user)       { Fabricate(:user) }
      let(:id)         { user.id }
      let(:first_name) { FFaker::Name.first_name }
      let(:last_name)  { FFaker::Name.last_name }
      let(:email)      { FFaker::Internet.email }
      let(:password)   { FFaker::Internet.password }
      let(:role)       { User::ROLES.sample }

      let!(:current_user) { Fabricate(:user, auth_token: 'test123123', role: 'admin') }

      example_request '(UPDATE) Update user' do
        expect(status).to be(200)
        expect(JSON.parse(response_body)['data']).to eq(user_hash(User.last))
      end
    end

    context 'with invalid params', document: nil do
      let!(:current_user) { Fabricate(:user, auth_token: 'test123123', role: 'admin') }
      let(:id)            { 100_500 }

      example_request 'Get error message' do
        expect(status).to be(404)
        expect(JSON.parse(response_body)['error']).to eq({
          'status' => 404, 'title' => 'Resource not found'
        })
      end
    end
  end

  delete '/api/v1/users/:id' do
    header 'Authorization', 'Token token=test123123'
    parameter :id, 'User ID', type: 'Integer', required: true

    context 'with valid params' do
      let(:user) { Fabricate(:user) }
      let(:id)   { user.id }

      let!(:current_user) { Fabricate(:user, auth_token: 'test123123', role: 'admin') }

      example_request '(DELETE) Delete user' do
        expect(status).to be(200)
        expect(User.count).to be(1)
        expect(JSON.parse(response_body)['data']).to eq(user_hash(user))
      end
    end

    context 'with invalid params', document: nil do
      let!(:current_user) { Fabricate(:user, auth_token: 'test123123', role: 'admin') }
      let(:id)            { 100_500 }

      example_request 'Get error message' do
        expect(status).to be(404)
        expect(JSON.parse(response_body)['error']).to eq({
          'status' => 404, 'title' => 'Resource not found'
        })
      end
    end
  end
end
