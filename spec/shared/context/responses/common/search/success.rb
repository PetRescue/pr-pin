RSpec.shared_context 'responses.search.success' do
  let(:params) do
    {
      query: query,
      page: page,
      per_page: per_page
    }
  end
  let(:query) { 'test' }
  let(:page) { 1 }
  let(:per_page) { 3 }
  let(:total_count) { 3 }
  let(:successful_response) do
    {
      response: records.map { |record| representer.(record) },
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
