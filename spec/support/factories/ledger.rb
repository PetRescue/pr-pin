Factory.define(:ledger, relation: :ledger) do |f|
  f.type { 'credit' }
  f.annotation { 'charge_credit' }
  f.amount { SecureRandom.random_number(10_000..50_000) }
  f.currency { 'AUD' }
  f.created_at { DateTime.now.to_json }
end
