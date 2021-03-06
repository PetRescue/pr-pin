Factory.define(:subscription) do |f|
  f.state { 'active' }
  f.next_billing_date { [nil, DateTime.now.next_month.to_json].sample }
  f.active_interval_started_at { [nil, DateTime.now.prev_month.to_json].sample }
  f.active_interval_finishes_at { [nil, DateTime.now.next_month(5).to_json].sample }
  f.cancelled_at { nil }
  f.created_at { DateTime.now.to_json }
  f.token { ['sub', fake(:number, :hexadecimal, digits: 22)].join('_') }
  f.plan_token { ['plan', fake(:number, :hexadecimal, digits: 22)].join('_') }
  f.customer_token { ['cus', fake(:number, :hexadecimal, digits: 22)].join('_') }
  f.card_token { ['card', fake(:number, :hexadecimal, digits: 22)].join('_') }
end
