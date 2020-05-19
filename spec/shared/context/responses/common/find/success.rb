RSpec.shared_context 'responses.find.success' do
  let(:successful_response) do
    { response: representer.(record) }
  end
  let(:successful_response_json) { JSON.dump(successful_response) }
end
