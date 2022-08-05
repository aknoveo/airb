FactoryBot.define do
  factory :listing do
    guests { 1 }
    bedrooms { 1 }
    bathrooms { 1 }
    city { Faker::Sports::Basketball }
    country { Faker::Sports::Football }
    street { Faker::Games::StreetFighter }
    apt_number { 1 }
    description { Faker::Lorem }
    name { Faker::Name.name }
    user
  end

  factory :user do
    email { Faker::Internet.email }
    password { "password" }
  end

  factory :reservation do
    start_date { Date.today }
    end_date { 1.week.from_now }
    listing
  end
end
