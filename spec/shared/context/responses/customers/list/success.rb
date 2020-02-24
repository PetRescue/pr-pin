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
    Array.new(per_page) { Factory.structs[:customer] }
  end
  let(:successful_response) do
    {
      response: customers.map { |customer|
        {
          token: customer.token,
          email: customer.email,
          created_at: customer.created_at,
          card: customer.card
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
