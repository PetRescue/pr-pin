RSpec.shared_context 'responses.plans.create.success' do
  let(:plan) { Factory.structs[:plan] }
  let(:successful_response) do
    {
      response: {
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
    }
  end
  let(:successful_response_json) { JSON.dump(successful_response) }
end
