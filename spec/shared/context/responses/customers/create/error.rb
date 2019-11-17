RSpec.shared_context 'responses.customers.create.error' do
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
  let(:error_response_json) { JSON.dump(error_response) }
end
