RSpec.describe 'PR::Pin.charges.search' do
  let(:representer) { Representers::JSONHash::Charge.new }

  context 'single request' do
    include_context 'responses.search.success' do
      let(:records) do
        Array.new(per_page) { Factory.structs[:charge] }
      end
    end

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
      PR::Pin.charges.search(**params)
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
    it { expect(result[0]).to eql(records[0]) }
    it { expect(result[1]).to eql(records[1]) }
    it { expect(result[2]).to eql(records[2]) }
  end

  context 'paginated requests' do
    it_behaves_like 'a_paginated_response' do
      let(:uri) { 'https://test-api.pinpayments.com/1/charges/search' }
      let(:records) do
        Array.new(total_count) { Factory.structs[:charge] }
      end
      let(:base_result) { PR::Pin.charges.search(**params) }
    end
  end
end
