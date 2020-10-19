RSpec.shared_context 'responses.update.success' do
  let(:successful_response) do
    { response: representer.(updated_record) }
  end
  let(:successful_response_json) { JSON.dump(successful_response) }
end
