FactoryGirl.define do
  factory :task do
    name "Prep"
    order 1
    finished false
    project
  end
end
