RSpec.shared_context 'responses.plans.create.error' do
  let(:error_response) do
    {
      error: 'unprocessable_entity',
      error_description: 'Validation failure'
    }
  end
  let(:error_response_json) { JSON.dump(error_response) }
end
