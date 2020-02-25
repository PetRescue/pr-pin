RSpec.describe 'PR::Pin.charges.create' do
  let(:representer) { Representers::JSONHash::Charge.new }

  context 'successful response' do
    include_context 'responses.create.success' do
      let(:record) { Factory.structs[:charge] }
    end

    let(:params) do
      {
        email: record.email,
        description: record.description,
        amount: record.amount,
        ip_address: record.ip_address
      }
    end
    let!(:request_stub) do
      stub_request(
        :post,
        'https://test-api.pinpayments.com/1/charges'
      ).with(
        body: params,
        basic_auth: [PIN_SECRET_KEY, ''],
        headers: {
          'Content-Type' => 'application/json'
        }
      ).to_return(body: successful_response_json, status: 201)
    end


    subject!(:result) do
      PR::Pin.charges.create(params)
    end

    it { expect(request_stub).to have_been_requested }
    it { expect(result.success?).to be_truthy }
    it { expect(result.error?).to be_falsey }
    it { expect(result).to eql(record) }
  end

  context 'error response' do
    let(:record) { Factory.structs[:charge] }

    include_context 'responses.charges.create.error'

    let(:params) do
      {
        email: record.email,
        description: record.description,
        amount: record.amount,
        ip_address: record.ip_address
      }
    end
    let!(:request_stub) do
      stub_request(
        :post,
        'https://test-api.pinpayments.com/1/charges'
      ).with(
        body: params,
        basic_auth: [PIN_SECRET_KEY, ''],
        headers: {
          'Content-Type' => 'application/json'
        }
      ).to_return(body: error_response_json, status: 422)
    end

    subject!(:error) do
      PR::Pin.charges.create(params)
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
        code: 'description_invalid',
        message: "Description can't be blank",
        param: 'description'
      )
    end
  end
end
