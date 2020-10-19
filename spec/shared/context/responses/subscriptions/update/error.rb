RSpec.shared_context 'responses.subscriptions.update.error' do
  let(:error_response) do
    {
      error: 'invalid_resource',
      error_description: 'One or more parameters were missing or invalid',
      messages: [
        {
          code: 'card_token_invalid',
          message: "Card token can't be blank",
          param: 'card_token'
        }
      ]
    }
  end
  let(:error_response_json) { JSON.dump(error_response) }
end
