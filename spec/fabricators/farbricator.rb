Fabricator(:user) do
  first_name { FFaker::Name.first_name }
  last_name  { FFaker::Name.last_name }
  email      { FFaker::Internet.email }
  password   { FFaker::Internet.password }
  role       { User::ROLES.sample }
  auth_token { SecureRandom.uuid.gsub(/\-/,'') }
end

Fabricator(:event) do
  name        { FFaker::Lorem.word }
  description { FFaker::Lorem.phrase }
  location    { FFaker::Address.city }
  date        { FFaker::Time.date }
  user
end

Fabricator(:item) do
  description { FFaker::Lorem.phrase }
  comment     { FFaker::Lorem.phrase }
  event
end
