require 'rails_helper'

RSpec.feature "Customers", type: :feature do
  it 'Visit index page' do
    visit(customers_path)
    expect(page).to have_current_path(customers_path)
  end
end
