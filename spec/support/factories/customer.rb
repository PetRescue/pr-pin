Factory.define(:customer) do |f|
  f.token { ['cus', fake(:number, :hexadecimal, 22)].join('_') }
  f.email { fake(:internet, :email) }
  f.created_at { DateTime.now.to_json }
  f.card do |token|
    {
      token: ['card', fake(:number, :hexadecimal, 22)].join('_'),
      scheme: 'visa',
      display_number: ['XXXX-XXXX-XXXX', fake(:number, :number, 4)].join('-'),
      issuing_country: fake(:address, :country_code),
      expiry_month: SecureRandom.random_number(1..12),
      expiry_year: Date.today.next_year.year,
      name: fake(:name, :name),
      address_line1: fake(:address, :street_address),
      address_line2: fake(:address, :secondary_address),
      address_city: fake(:address, :city),
      address_postcode: fake(:address, :postcode),
      address_state: fake(:address, :state),
      address_country: 'Australia',
      customer_token: token,
      primary: true
    }
  end
end
