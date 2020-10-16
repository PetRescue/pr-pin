Factory.define(:plan) do |f|
  f.name { fake(:name, :name) }
  f.amount { fake(:number, :rand, 10_000..50_000) }
  f.currency { 'AUD' }
  f.setup_amount { 0 }
  f.trial_amount { 0 }
  f.interval { 1 }
  f.interval_unit { 'month' }
  f.intervals { 0 }
  f.trial_interval { 0 }
  f.trial_interval_unit { '' }
  f.created_at { DateTime.now.to_json }
  f.token { ['plan', fake(:number, :hexadecimal, digits: 22)].join('_') }
  f.customer_permissions { %w(cancel) }
  f.subscription_counts do
    {
      trial: 0,
      active: 0,
      cancelling: 0,
      cancelled: 0
    }
  end
end
