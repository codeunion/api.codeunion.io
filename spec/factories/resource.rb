FactoryGirl.define do
  factory :resource do
    sequence :name do |n|
      "Resource #{n}"
    end

    category "project"
    manifest "{}"

    factory :findable_resource do
      readme "findable resource with some information"
    end

    factory :unfindable_resource do
      readme "don't find me!"
    end
  end
end
