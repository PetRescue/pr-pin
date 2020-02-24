RSpec.describe 'PR::Pin.charges.search' do
  include_context 'responses.charges.search.success'

  let!(:request_stub) do
    stub_request(
      :get,
      'https://test-api.pinpayments.com/1/charges/search'
    ).with(
      query: params,
      basic_auth: [PIN_SECRET_KEY, ''],
      headers: {
        'Content-Type' => 'application/json'
      }
    ).to_return(body: successful_response_json, status: 200)
  end

  subject!(:result) do
    PR::Pin.charges.search(params)
  end

  it { expect(request_stub).to have_been_requested }
  it { expect(result.success?).to be_truthy }
  it { expect(result.error?).to be_falsey }
  it { expect(result.length).to eql(3) }
  it { expect(result.current_page).to eql(1) }
  it { expect(result.next_page).to be_nil }
  it { expect(result.prev_page).to be_nil }
  it { expect(result.per_page).to eql(3) }
  it { expect(result.total_pages).to eql(1) }
  it { expect(result.total_count).to eql(3) }
  it { expect(result[0]).to eql(charges[0]) }
  it { expect(result[1]).to eql(charges[1]) }
  it { expect(result[2]).to eql(charges[2]) }
end
