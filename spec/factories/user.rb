FactoryBot.define do

  factory :user do
    email 'test@example.com'
    password '12345678'  

    factory :admin_user do
      email 'admin@example.com'
      password '12345678'
      role 'admin'
    end  

  end
end