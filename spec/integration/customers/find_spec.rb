RSpec.describe 'PR::Pin.customers.find' do
  let(:representer) { Representers::JSONHash::Customer.new }

  context 'successful response' do
    include_context 'responses.find.success' do
      let(:record) { Factory.structs[:customer] }
    end

    let!(:request_stub) do
      stub_request(
        :get,
        "https://test-api.pinpayments.com/1/customers/#{record.token}"
      ).with(
        basic_auth: [PIN_SECRET_KEY, ''],
        headers: {
          'Content-Type' => 'application/json'
        }
      ).to_return(body: successful_response_json, status: 200)
    end

    subject!(:result) do
      PR::Pin.customers.find(record.token)
    end

    it { expect(request_stub).to have_been_requested }
    it { expect(result.success?).to be_truthy }
    it { expect(result.error?).to be_falsey }
    it { expect(result).to eql(record) }
  end

  context 'error response' do
    include_context 'responses.not_found'

    let(:record) { Factory.structs[:customer] }

    let!(:request_stub) do
      stub_request(
        :get,
        "https://test-api.pinpayments.com/1/customers/#{record.token}"
      ).with(
        basic_auth: [PIN_SECRET_KEY, ''],
        headers: {
          'Content-Type' => 'application/json'
        }
      ).to_return(body: error_response_json, status: 404)
    end

    subject!(:error) do
      PR::Pin.customers.find(record.token)
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
