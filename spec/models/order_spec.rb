require 'rails_helper'

RSpec.describe Order, type: :model do
  it 'belongs_to' do
    order = create(:order)
    expect(order.customer).to be_kind_of(Customer)
  end

  it 'Create 3 orders - create_list' do
    orders = create_list(:order, 3) # Create multiple order instances and stores in an array
    # create_list(:nameofclass, number of instances)
    expect(orders.count).to eq(3)
  end

  it 'has_many' do
    customer = create(:customer, :with_orders)
    expect(customer.orders.count).to eq(3)
  end

  it 'has_many - change number of orders' do
    customer = create(:customer, :with_orders, quantity_orders: 5)
    expect(customer.orders.count).to eq(5)
  end
end
