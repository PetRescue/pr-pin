RSpec.shared_context 'create customer responses' do
  let(:customer) { Factory.structs[:customer] }
  let(:successful_response) do
    {
      response: {
        token: customer.token,
        email: customer.email,
        created_at: customer.created_at,
        card: {
          token: customer.card[:token],
          scheme: customer.card[:scheme],
          display_number: customer.card[:display_number],
          issuing_country: customer.card[:issuing_country],
          expiry_month: customer.card[:expiry_month],
          expiry_year: customer.card[:expiry_year],
          name: customer.card[:name],
          address_line1: customer.card[:address_line1],
          address_line2: customer.card[:address_line2],
          address_city: customer.card[:address_city],
          address_postcode: customer.card[:address_postcode],
          address_state: customer.card[:address_state],
          address_country: customer.card[:address_country],
          customer_token: customer.card[:customer_token],
          primary: customer.card[:primary]
        }
      }
    }
  end
  let(:error_response) do
    {
      error: 'invalid_resource',
      error_description: 'One or more parameters were missing or invalid',
      messages: [
        {
          code: 'email_invalid',
          message: "Email isn't valid",
          param: 'email'
        }
      ]
    }
  end

  let(:successful_response_json) { JSON.dump(successful_response) }
  let(:error_response_json) { JSON.dump(error_response) }
end
