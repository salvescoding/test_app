FactoryBot.define do
  factory :customer do

    transient do
      upcased false
      quantity_orders 3
    end

    name  Faker::Name.name
    email Faker::Internet.email
    address Faker::Address.street_address

    trait :male do
      gender 'M'
    end

    trait :female do
      gender 'F'
    end

    trait :vip do
      vip true
      days_to_pay 30
    end

    trait :default do
      vip false
      days_to_pay 10
    end

    trait :with_orders do
      after(:create) do |customer, evaluator|
        create_list(:order, evaluator.quantity_orders, customer: customer)
      end
    end

    factory :customer_male, traits: [:male]
    factory :customer_female, traits: [:female]
    factory :customer_vip, traits: [:vip]
    factory :customer_default, traits: [:default]
    factory :customer_male_default, traits: [:default, :male]
    factory :customer_female_default, traits: [:default, :female]
    factory :customer_female_vip, traits: [:vip, :female]
    factory :customer_male_vip, traits: [:vip, :male]


    after(:create) do |customer, evaluator|
      customer.name.upcase! if evaluator.upcased
    end
  end
end
