Factory.define(:refund) do |f|
  f.token { ['rf', fake(:number, :hexadecimal, 22)].join('_') }
  f.success { true }
  f.amount { SecureRandom.random_number(10_000..50_000) }
  f.currency { 'AUD' }
  f.charge { ['ch', fake(:number, :hexadecimal, 22)].join('_') }
  f.error_message { nil }
  f.status_message { 'Success' }
  f.created_at { DateTime.now.to_json }
end
