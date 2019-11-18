RSpec.shared_context 'responses.plans.list.success' do
  let(:params) do
    {
      page: page,
      per_page: per_page
    }
  end
  let(:page) { 1 }
  let(:per_page) { 3 }
  let(:total_count) { 3 }
  let(:plans) do
    per_page.times.map { Factory.structs[:plan] }
  end
  let(:successful_response) do
    {
      response: plans.map { |plan|
        {
          name: plan.name,
          amount: plan.amount,
          currency: plan.currency,
          setup_amount: plan.setup_amount,
          trial_amount: plan.trial_amount,
          interval: plan.interval,
          interval_unit: plan.interval_unit,
          intervals: plan.intervals,
          trial_interval: plan.trial_interval,
          trial_interval_unit: plan.trial_interval_unit,
          created_at: plan.created_at,
          token: plan.token,
          customer_permissions: plan.customer_permissions,
          subscription_counts: plan.subscription_counts
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
