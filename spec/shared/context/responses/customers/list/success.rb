RSpec.shared_context 'responses.customers.list.success' do
  let(:params) do
    {
      page: page,
      per_page: per_page
    }
  end
  let(:page) { 1 }
  let(:per_page) { 3 }
  let(:total_count) { 3 }
  let(:customers) do
    per_page.times.map { Factory.structs[:customer] }
  end
  let(:successful_response) do
    {
      response: customers.map { |customer|
        {
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
      },
      count: total_count,
      pagination: {
        current: page,
        per_page: per_page,
        pages: (total_count / per_page.to_f).ceil,
        count: total_count
      }
    }
  end
  let(:successful_response_json) { JSON.dump(successful_response) }
end
