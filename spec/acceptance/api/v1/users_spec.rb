require 'rails_helper'

RSpec.resource 'Users' do
  get '/api/v1/users' do
  end

  get '/api/v1/users/:id' do
    parameter :id, 'User ID', type: 'Integer', required: true
  end

  post '/api/v1/users' do
  end

  put '/api/v1/users/:id' do
    parameter :id, 'User ID', type: 'Integer', required: true
  end

  delete '/api/v1/users/:id' do
    parameter :id, 'User ID', type: 'Integer', required: true
  end
end
