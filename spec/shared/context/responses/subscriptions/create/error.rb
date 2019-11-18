RSpec.shared_context 'responses.subscriptions.create.error' do
  let(:error_response) do
    {
      error: 'invalid_request',
      error_description: 'One or more parameters are missing or invalid.',
      messages: [
        {
          param: 'plan_token',
          message: 'must be present'
        }
      ]
    }
  end
  let(:error_response_json) { JSON.dump(error_response) }
end
