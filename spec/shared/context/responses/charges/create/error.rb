RSpec.shared_context 'responses.charges.create.error' do
  let(:error_response) do
    {
      error: 'invalid_resource',
      error_description: 'One or more parameters were missing or invalid',
      messages: [
        {
          code: 'description_invalid',
          message: "Description can't be blank",
          param: 'description'
        }
      ]
    }
  end
  let(:error_response_json) { JSON.dump(error_response) }
end
