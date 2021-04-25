FactoryBot.define do
  factory :user do
    email { "#{Faker::Internet.username}@gmail.com" }
  end
end
