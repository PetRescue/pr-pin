RSpec.shared_context 'responses.plans.update.error' do
  let(:error_response) do
    {
      error: 'invalid_resource',
      error_description: 'One or more parameters were missing or invalid',
      messages: [
        {
          code: 'name_invalid',
          message: "Name can't be blank",
          param: 'name'
        }
      ]
    }
  end
  let(:error_response_json) { JSON.dump(error_response) }
end
