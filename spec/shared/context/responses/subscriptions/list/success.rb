RSpec.shared_context 'responses.subscriptions.list.success' do
  let(:params) do
    {
      page: page,
      per_page: per_page
    }
  end
  let(:page) { 1 }
  let(:per_page) { 3 }
  let(:total_count) { 3 }
  let(:subscriptions) do
    per_page.times.map { Factory.structs[:subscription] }
  end
  let(:successful_response) do
    {
      response: subscriptions.map { |subscription|
        {
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
