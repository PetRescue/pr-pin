RSpec.shared_context 'responses.charges.list.success' do
  let(:params) do
    {
      page: page,
      per_page: per_page
    }
  end
  let(:page) { 1 }
  let(:per_page) { 3 }
  let(:total_count) { 3 }
  let(:charges) do
    Array.new(per_page) { Factory.structs[:charge] }
  end
  let(:successful_response) do
    {
      response: charges.map { |charge|
        {
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
      },
      count: total_count,
      pagination: {
        current: page,
        per_page: per_page,
        pages: (total_count / per_page.to_f).ceil,
        count: total_count
      }
    }
  end
  let(:successful_response_json) { JSON.dump(successful_response) }
end
