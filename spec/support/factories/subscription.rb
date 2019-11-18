Factory.define(:subscription) do |f|
  f.state { 'active' }
  f.next_billing_date { DateTime.now.next_month.to_json }
  f.active_interval_started_at { DateTime.now.prev_month.to_json }
  f.active_interval_finishes_at { DateTime.now.next_month(5).to_json }
  f.cancelled_at { nil }
  f.created_at { DateTime.now.to_json }
  f.token { ['sub', fake(:number, :hexadecimal, 22)].join('_') }
  f.plan_token { ['plan', fake(:number, :hexadecimal, 22)].join('_') }
  f.customer_token { ['cus', fake(:number, :hexadecimal, 22)].join('_') }
  f.card_token { ['card', fake(:number, :hexadecimal, 22)].join('_') }
end
