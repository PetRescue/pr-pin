RSpec.shared_context 'responses.charges.create.success' do
  let(:charge) { Factory.structs[:charge] }
  let(:successful_response) do
    {
      response: {
        token: charge.token,
        success: charge.success,
        amount: charge.amount,
        currency: charge.currency,
        description: charge.description,
        email: charge.email,
        ip_address: charge.ip_address,
        created_at: charge.created_at,
        status_message: charge.status_message,
        error_message: charge.error_message,
        card: charge.card,
        transfer: charge.transfer,
        amount_refunded: charge.amount_refunded,
        total_fees: charge.total_fees,
        merchant_entitlement: charge.merchant_entitlement,
        refund_pending: charge.refund_pending,
        authorisation_expired: charge.authorisation_expired,
        captured: charge.captured,
        captured_at: charge.captured_at,
        settlement_currency: charge.settlement_currency,
        metadata: charge.metadata
      }
    }
  end
  let(:successful_response_json) { JSON.dump(successful_response) }
end
