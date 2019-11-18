RSpec.shared_context 'responses.customers.create.success' do
  let(:customer) { Factory.structs[:customer] }
  let(:successful_response) do
    {
      response: {
        token: customer.token,
        email: customer.email,
        created_at: customer.created_at,
        card: customer.card
      }
    }
  end
  let(:successful_response_json) { JSON.dump(successful_response) }
end
