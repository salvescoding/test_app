require 'rails_helper'

RSpec.describe Product, type: :model do

  context 'Validations' do
    it { is_expected.to validate_presence_of(:description) }

    it { is_expected.to validate_presence_of(:price) }

    it { is_expected.to validate_presence_of(:category) }
  end

  context 'Associations' do
    it { is_expected.to belong_to(:category) }
  end

  it 'valid with description, price and category' do
    product = create(:product)
    expect(product).to be_valid
  end

  context 'Instance methods' do
    it '#full_description' do
      product = create(:product)
      expect(product.full_description).to eq("#{product.description} - Price: #{product.price}, Category: #{product.category}")
    end
  end
end
