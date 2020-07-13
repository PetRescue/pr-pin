RSpec.shared_context 'responses.refunds.create_for_charge.error' do
  let(:error_response) do
    {
      error: 'insufficient_pin_balance',
      error_description: 'Refund amount is more than your available Pin Payments balance.'
    }
  end
  let(:error_response_json) { JSON.dump(error_response) }
end
