require 'rails_helper'

RSpec.describe Customer, type: :model do

  it '#full_name' do
    customer = create(:customer)
    expect(customer.full_name).to start_with("Sr ")
  end

  it '#full_name - overwrite attributes' do
    customer = create(:customer, name: "Sergio Alves")
    expect(customer.full_name).to start_with("Sr Sergio Alves")
  end

  it { expect { create(:customer) }.to change {Customer.all.size}.by(1) }

  it 'Inehritance' do
    customer = create(:customer_vip)
    expect(customer.vip).to eq(true)
  end

  it 'Using attributes_for' do
    attrs = attributes_for(:customer)
    customer = Customer.create(attrs)
    expect(customer.full_name).to start_with("Sr ")
  end

  it 'Transitory attributes' do
    customer = create(:customer, upcased: true)
    expect(customer.name.upcase).to eq(customer.name)
  end

  it 'Male vip customer' do
    customer = create(:customer_male_vip)
    expect(customer.gender).to eq('M')
    expect(customer.vip).to eq(true)
  end

  it 'female default customer' do
    customer = create(:customer_female_default)
    expect(customer.gender).to eq('F')
    expect(customer.vip).to eq(false)
  end

  it 'travel_to' do
    travel_to Time.zone.local(2004, 11, 24, 01, 04, 44) do
      @c = create(:customer_male_vip)
    end
    expect(@c.created_at).to be < Time.now
  end

end
