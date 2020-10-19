RSpec.describe 'PR::Pin.refunds.for_charge' do
  let(:representer) { Representers::JSONHash::Refund.new }
  let(:charge) { Factory.structs[:charge] }

  context 'single request' do
    include_context 'responses.list.success' do
      let(:records) do
        Array.new(per_page) { Factory.structs[:refund] }
      end
    end

    let!(:request_stub) do
      stub_request(
        :get,
        "https://test-api.pinpayments.com/1/charges/#{charge.token}/refunds"
      ).with(
        query: params,
        basic_auth: [PIN_SECRET_KEY, ''],
        headers: {
          'Content-Type' => 'application/json'
        }
      ).to_return(body: successful_response_json, status: 200)
    end

    subject!(:result) do
      PR::Pin.refunds.for_charge(charge.token, **params)
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
      let(:uri) { "https://test-api.pinpayments.com/1/charges/#{charge.token}/refunds" }
      let(:records) do
        Array.new(total_count) { Factory.structs[:refund] }
      end
      let(:base_result) { PR::Pin.refunds.for_charge(charge.token, **params) }
    end
  end

  context 'error response' do
    include_context 'responses.not_found'

    let(:record) { Factory.structs[:charge] }
    let(:params) do
      { page: 1, per_page: 10 }
    end

    let!(:request_stub) do
      stub_request(
        :get,
        "https://test-api.pinpayments.com/1/charges/#{record.token}/refunds"
      ).with(
        query: params,
        basic_auth: [PIN_SECRET_KEY, ''],
        headers: {
          'Content-Type' => 'application/json'
        }
      ).to_return(body: error_response_json, status: 404)
    end

    subject!(:error) do
      PR::Pin.refunds.for_charge(record.token, **params)
    end

    it { expect(request_stub).to have_been_requested }
    it { expect(error.success?).to be_falsey }
    it { expect(error.error?).to be_truthy }
    it { expect(error.response_code).to eql('404') }
    it { expect(error.code).to eql('not_found') }
    it do
      expect(error.description).to eql(
        'The requested resource could not be found.'
      )
    end
    it { expect(error.messages).to be_empty }
  end
end
