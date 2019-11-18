RSpec.describe 'PR::Pin.subscriptions.create' do
  context 'successful response' do
    include_context 'responses.subscriptions.create.success'

    let(:params) do
      {
        plan_token: subscription.plan_token,
        customer_token: subscription.customer_token
      }
    end
    let!(:request_stub) do
      stub_request(
        :post,
        'https://test-api.pinpayments.com/1/subscriptions'
      ).with(
        body: params,
        basic_auth: [PIN_SECRET_KEY, ''],
        headers: {
          'Content-Type' => 'application/json'
        }
      ).to_return(body: successful_response_json, status: 201)
    end


    subject!(:result) do
      PR::Pin.subscriptions.create(params)
    end

    it { expect(request_stub).to have_been_requested }
    it { expect(result.success?).to be_truthy }
    it { expect(result.error?).to be_falsey }
    it { expect(result).to eql(subscription) }
  end

  context 'error response' do
    let(:subscription) { Factory.structs[:subscription] }

    include_context 'responses.subscriptions.create.error'

    let(:params) do
      {
        plan_token: nil,
        customer_token: subscription.customer_token
      }
    end
    let!(:request_stub) do
      stub_request(
        :post,
        'https://test-api.pinpayments.com/1/subscriptions'
      ).with(
        body: params,
        basic_auth: [PIN_SECRET_KEY, ''],
        headers: {
          'Content-Type' => 'application/json'
        }
      ).to_return(body: error_response_json, status: 400)
    end

    subject!(:error) do
      PR::Pin.subscriptions.create(params)
    end

    it { expect(request_stub).to have_been_requested }
    it { expect(error.success?).to be_falsey }
    it { expect(error.error?).to be_truthy }
    it { expect(error.response_code).to eql('400') }
    it { expect(error.code).to eql('invalid_request') }
    it do
      expect(error.description).to eql(
        'One or more parameters are missing or invalid.'
      )
    end
    it do
      expect(error.messages).to contain_exactly(
        message: 'must be present',
        param: 'plan_token'
      )
    end
  end
end
