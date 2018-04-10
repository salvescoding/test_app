FactoryBot.define do
  factory :order do
    sequence(:description) { |n| "Order number #{n}" }
    customer # This associates every order with a Customer object
    # to associate manually do
    #### association :customer, factory: :customer ####
  end
end
