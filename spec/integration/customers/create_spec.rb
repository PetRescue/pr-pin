RSpec.describe 'PR::Pin.customers.create' do
  let(:representer) { Representers::JSONHash::Customer.new }

  context 'successful response' do
    include_context 'responses.create.success' do
      let(:record) { Factory.structs[:customer] }
    end

    let(:params) do
      {
        email: record.email,
        card_token: record.card[:token]
      }
    end
    let!(:request_stub) do
      stub_request(
        :post,
        'https://test-api.pinpayments.com/1/customers'
      ).with(
        body: params,
        basic_auth: [PIN_SECRET_KEY, ''],
        headers: {
          'Content-Type' => 'application/json'
        }
      ).to_return(body: successful_response_json, status: 201)
    end


    subject!(:result) do
      PR::Pin.customers.create(params)
    end

    it { expect(request_stub).to have_been_requested }
    it { expect(result.success?).to be_truthy }
    it { expect(result.error?).to be_falsey }
    it { expect(result).to eql(record) }
  end

  context 'error response' do
    let(:record) { Factory.structs[:customer] }

    include_context 'responses.customers.create.error'

    let(:params) do
      {
        email: record.email,
        card_token: record.card[:token]
      }
    end
    let!(:request_stub) do
      stub_request(
        :post,
        'https://test-api.pinpayments.com/1/customers'
      ).with(
        body: params,
        basic_auth: [PIN_SECRET_KEY, ''],
        headers: {
          'Content-Type' => 'application/json'
        }
      ).to_return(body: error_response_json, status: 422)
    end

    subject!(:error) do
      PR::Pin.customers.create(params)
    end

    it { expect(request_stub).to have_been_requested }
    it { expect(error.success?).to be_falsey }
    it { expect(error.error?).to be_truthy }
    it { expect(error.response_code).to eql('422') }
    it { expect(error.code).to eql('invalid_resource') }
    it do
      expect(error.description).to eql(
        'One or more parameters were missing or invalid'
      )
    end
    it do
      expect(error.messages).to contain_exactly(
        code: 'email_invalid',
        message: "Email isn't valid",
        param: 'email'
      )
    end
  end
end
