RSpec.shared_context 'responses.subscriptions.create.success' do
  let(:subscription) { Factory.structs[:subscription] }
  let(:successful_response) do
    {
      response: {
        state: subscription.state,
        next_billing_date: subscription.next_billing_date,
        active_interval_started_at: subscription.active_interval_started_at,
        active_interval_finishes_at: subscription.active_interval_finishes_at,
        cancelled_at: subscription.cancelled_at,
        created_at: subscription.created_at,
        token: subscription.token,
        plan_token: subscription.plan_token,
        customer_token: subscription.customer_token,
        card_token: subscription.card_token
      }
    }
  end
  let(:successful_response_json) { JSON.dump(successful_response) }
end
