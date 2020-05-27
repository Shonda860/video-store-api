require "test_helper"

describe CustomersController do
  
  REQUIRED_CUSTOMERS_FIELDS = ["customer_id","name", "registered_at", "postal_code","phone", "videos_checked_out_count"].sort


  def check_response(expected_type:, expected_status: :success)
    must_respond_with expected_status
    expect(response.header['Content-Type']).must_include 'json'

    body = JSON.parse(response.body)
    expect(body).must_be_kind_of expected_type
    return body
  end
  describe "index" do 
    it "responds with JSON and success" do
      get customers_path

      body = check_response(expected_type: Array)

      body.each do |customer|
        expect(customer).must_be_instance_of Hash
        expect(customer.keys.sort).must_equal REQUIRED_CUSTOMERS_FIELDS
      end
    end
  end
end
