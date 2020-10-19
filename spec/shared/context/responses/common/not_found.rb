RSpec.shared_context 'responses.not_found' do
  let(:error_response) do
    {
      error: 'not_found',
      error_description: 'The requested resource could not be found.'
    }
  end
  let(:error_response_json) { JSON.dump(error_response) }
end
