require 'rails_helper'


RSpec.describe "Customers", type: :request do
  describe "GET /customers" do

    it 'JSON - Schema' do
      get '/customers/1.json'
      p JSON.parse(response.body)
      expect(response).to match_response_schema("customer")
    end

    it "works 200 OK" do
      get customers_path
      expect(response).to have_http_status(200)
    end

    it "Index - JSON 200 OK" do
      get "/customers.json"
      expect(response).to have_http_status(200)
      expect(response.body).to include_json([
        id: 1,
        name: "Mrs. Zackery McClure",
        email: "cheyanne@boehm.co"
        ])
    end

    it "show - JSON 200 OK" do
      get "/customers/1.json"
      expect(response).to have_http_status(200)
      expect(response.body).to include_json(
        id: 1
        )
    end

    it "JSON returns the correct data type for email/id/name" do
      get "/customers.json"
      expect(response).to have_http_status(200)
      expect(response.body).to include_json([
        id: (be_kind_of Integer),
        name: (be_kind_of String),
        email: (be_kind_of String)
        ])
    end

    it "show - JSON Rspec pure" do
      get "/customers/1.json"
      json_respo = JSON.parse(response.body)
      expect(json_respo.fetch("id")).to eq(1)
      expect(json_respo.fetch("name")).to be_kind_of(String)
      expect(json_respo.fetch("email")).to be_kind_of(String)
    end

    # it '#create customer - JSON' do
    #   user = create(:user)
    #   login_as(user, scope: :user) # login_as is not working

    #   # This will tell that we are creating a customer with the format JSON
    #   # when creating using JSON format we need to tell it by writing the follow
    #   headers = { "ACCEPT" => "application/json" }

    #   customer_params = attributes_for(:customer)
    #   post "/customers.json", params: (customer: customer_params), headers: headers
    # end

    # it '#update customer - JSON' do
    #   user = create(:user)
    #   login_as(user, scope: :user) # login_as is not working

    #   # This will tell that we are creating a customer with the format JSON
    #   # when creating using JSON format we need to tell it by writing the follow
    #   headers = { "ACCEPT" => "application/json" }

    #   customer_params = attributes_for(:customer)
    #   post "/customers.json", params: (customer: customer_params), headers: headers
    # end
  end
end
