FactoryBot.define do
  pwd = Faker::Internet.password(8)
  factory :comment do
    user { User.create!(email: Faker::Internet.email, password: pwd, password_confirmation: pwd, name: Faker::Internet.email, confirmed_at: Time.current) }
    movie { FactoryBot.create(:movie) }
    body { Faker::Lorem.word }
  end
end
