RSpec.describe 'PR::Pin.plans.create' do
  context 'successful response' do
    include_context 'responses.plans.create.success'

    let(:params) do
      {
        name: plan.name,
        amount: plan.amount,
        currency: plan.currency,
        interval: plan.interval
      }
    end
    let!(:request_stub) do
      stub_request(
        :post,
        'https://test-api.pinpayments.com/1/plans'
      ).with(
        body: params,
        basic_auth: [PIN_SECRET_KEY, ''],
        headers: {
          'Content-Type' => 'application/json'
        }
      ).to_return(body: successful_response_json, status: 201)
    end


    subject!(:result) do
      PR::Pin.plans.create(params)
    end

    it { expect(request_stub).to have_been_requested }
    it { expect(result.success?).to be_truthy }
    it { expect(result.error?).to be_falsey }
    it { expect(result).to eql(plan) }
  end

  context 'error response' do
    let(:plan) { Factory.structs[:plan] }

    include_context 'responses.plans.create.error'

    let(:params) do
      {
        name: plan.name,
        amount: plan.amount,
        currency: plan.currency,
        interval: plan.interval
      }
    end
    let!(:request_stub) do
      stub_request(
        :post,
        'https://test-api.pinpayments.com/1/plans'
      ).with(
        body: params,
        basic_auth: [PIN_SECRET_KEY, ''],
        headers: {
          'Content-Type' => 'application/json'
        }
      ).to_return(body: error_response_json, status: 422)
    end

    subject!(:error) do
      PR::Pin.plans.create(params)
    end

    it { expect(request_stub).to have_been_requested }
    it { expect(error.success?).to be_falsey }
    it { expect(error.error?).to be_truthy }
    it { expect(error.response_code).to eql('422') }
    it { expect(error.code).to eql('unprocessable_entity') }
    it do
      expect(error.description).to eql(
        'Validation failure'
      )
    end
  end
end
