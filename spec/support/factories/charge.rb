Factory.define(:charge) do |f|
  f.token { ['ch', fake(:number, :hexadecimal, digits: 22)].join('_') }
  f.success { true }
  f.amount { SecureRandom.random_number(10_000..50_000) }
  f.currency { 'AUD' }
  f.description { fake(:lorem, :sentence) }
  f.email { fake(:internet, :email) }
  f.ip_address { fake(:internet, :ip_v4_address) }
  f.created_at { DateTime.now.to_json }
  f.status_message { 'Success' }
  f.error_message { nil }
  f.card do
    {
      token: ['card', fake(:number, :hexadecimal, digits: 22)].join('_'),
      scheme: 'visa',
      display_number: ['XXXX-XXXX-XXXX', fake(:number, :number, digits: 4)].join('-'),
      issuing_country: fake(:address, :country_code),
      expiry_month: fake(:number, :rand, 1..12),
      expiry_year: Date.today.next_year.year,
      name: fake(:name, :name),
      address_line1: fake(:address, :street_address),
      address_line2: fake(:address, :secondary_address),
      address_city: fake(:address, :city),
      address_postcode: fake(:address, :postcode),
      address_state: fake(:address, :state),
      address_country: 'Australia',
      customer_token: nil,
      primary: true
    }
  end
  f.transfer { [] }
  f.amount_refunded { 0 }
  f.total_fees { |amount| (amount * 0.105).to_i }
  f.merchant_entitlement { |amount, total_fees| amount - total_fees }
  f.refund_pending { false }
  f.authorisation_expired { false }
  f.captured { true }
  f.captured_at { DateTime.now.to_json }
  f.settlement_currency { 'AUD' }
  f.metadata do
    { key: 'value' }
  end
end
