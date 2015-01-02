FactoryGirl.define do
  factory :resource do
    manifest "{}"

    factory :findable_resource do
      readme "findable resource with some information"
    end

    factory :unfindable_resource do
      readme "don't find me!"
    end
  end
end
