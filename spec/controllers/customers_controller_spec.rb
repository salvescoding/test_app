require 'rails_helper'

RSpec.describe CustomersController, type: :controller do

  context 'Not authenticated user' do
    it 'Responds successfully' do
      get :index
      expect(response).to be_success
    end

    it 'Responds 200 HTTP request'do
      get :index
      expect(response).to have_http_status(200)
    end

    it 'Responds 302 HTTP request - not authorised'do
      customer = create(:customer)
      get :show, params: { id: customer.id }
      expect(response).to have_http_status(302)
    end
  end

  context 'authenticated user' do

    before do
      @customer = create(:customer)
      @user = create(:user)
    end

    it 'Content-type' do
      customer_params = attributes_for(:customer)
      sign_in @user
      post :create, format: :json, params: { customer: customer_params }
      expect(response.content_type).to eq("application/json")
    end

    it 'Flash notice' do
      customer_params = attributes_for(:customer)
      sign_in @user
      post :create, params: { customer: customer_params }
      expect(flash[:notice]).to match(/was successfully created/)

    end

    it 'save customer with valid attributes' do
      customer_params = attributes_for(:customer)
      sign_in @user
      expect {
        post :create, params: { customer: customer_params }
      }.to change(Customer, :count).by(1)
    end

    it 'cannot save customer with invalid attributes' do
      customer_params = attributes_for(:customer, address: nil)
      sign_in @user
      expect {
        post :create, params: { customer: customer_params }
      }.to_not change(Customer, :count)
    end

    it 'access #show after authenticate user' do
      sign_in @user
      get :show, params: { id: @customer.id }
      expect(response).to have_http_status(200)
    end

    it 'renders template #show' do
      sign_in @user
      get :show, params: { id: @customer.id }
      expect(response).to render_template(:show)
    end


  end

  context 'Routes' do
    it '/customers to action #index' do
      should route(:get, '/customers').to(action: :index)
    end
  end

end
