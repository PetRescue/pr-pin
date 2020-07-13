RSpec.describe 'PR::Pin.refunds.create_for_charge' do
  let(:representer) { Representers::JSONHash::Refund.new }
  let(:charge) { Factory.structs[:charge] }

  context 'successful response' do
    include_context 'responses.create.success' do
      let(:record) { Factory.structs[:refund] }
    end

    let(:params) do
      {
        amount: charge.amount
      }
    end
    let!(:request_stub) do
      stub_request(
        :post,
        "https://test-api.pinpayments.com/1/charges/#{charge.token}/refunds"
      ).with(
        body: params,
        basic_auth: [PIN_SECRET_KEY, ''],
        headers: {
          'Content-Type' => 'application/json'
        }
      ).to_return(body: successful_response_json, status: 201)
    end

    subject!(:result) do
      PR::Pin.refunds.create_for_charge(charge.token, params)
    end

    it { expect(request_stub).to have_been_requested }
    it { expect(result.success?).to be_truthy }
    it { expect(result.error?).to be_falsey }
    it { expect(result).to eql(record) }
  end

  context 'error response' do
    let(:record) { Factory.structs[:refund] }

    include_context 'responses.refunds.create_for_charge.error'

    let(:params) do
      {
        amount: record.amount
      }
    end
    let!(:request_stub) do
      stub_request(
        :post,
        "https://test-api.pinpayments.com/1/charges/#{charge.token}/refunds"
      ).with(
        body: params,
        basic_auth: [PIN_SECRET_KEY, ''],
        headers: {
          'Content-Type' => 'application/json'
        }
      ).to_return(body: error_response_json, status: 402)
    end

    subject!(:error) do
      PR::Pin.refunds.create_for_charge(charge.token, params)
    end

    it { expect(request_stub).to have_been_requested }
    it { expect(error.success?).to be_falsey }
    it { expect(error.error?).to be_truthy }
    it { expect(error.response_code).to eql('402') }
    it { expect(error.code).to eql(error_response[:error]) }
    it do
      expect(error.description).to eql(error_response[:error_description])
    end
  end
end
