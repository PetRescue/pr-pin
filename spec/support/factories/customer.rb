Factory.define(:customer) do |f|
  f.token { ['cus', fake(:number, :hexadecimal, digits: 22)].join('_') }
  f.email { fake(:internet, :email) }
  f.first_name { [nil, fake(:name, :first_name)].sample }
  f.last_name { [nil, fake(:name, :last_name)].sample }
  f.phone_number { [nil, fake(:phone_number, :phone_number)].sample }
  f.company { [nil, fake(:company, :name)].sample }
  f.notes { [nil, fake(:lorem, :sentence)].sample }
  f.created_at { DateTime.now.to_json }
  f.card do |token|
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
      customer_token: token,
      primary: true
    }
  end
end
