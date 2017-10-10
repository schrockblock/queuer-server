FactoryGirl.define do
  factory :user do
    api_key { SecureRandom.hex(20).encode('UTF-8') }
    username "eschrock"
    password "password"
    admin true
  end
end
