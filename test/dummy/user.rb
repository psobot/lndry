class User < ActiveRecord::Base
  dummy :name do
    Faker::Name.name
  end
  dummy :email do
    Faker::Internet.email
  end
end
