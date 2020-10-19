RSpec.describe 'PR::Pin.plans.update' do
  let(:representer) { Representers::JSONHash::Plan.new }

  context 'successful response' do
    include_context 'responses.update.success' do
      let(:record) { Factory.structs[:plan] }
      let(:updated_record) do
        Factory.structs[
          :plan, Transformations::Hash.except(record.attributes, record.attributes.keys - param_keys)
        ]
      end
    end

    let(:param_keys) { %i(name) }
    let(:params) { Transformations::Hash.slice(updated_record.attributes, param_keys) }
    let!(:request_stub) do
      stub_request(
        :put,
        "https://test-api.pinpayments.com/1/plans/#{record.token}"
      ).with(
        body: params,
        basic_auth: [PIN_SECRET_KEY, ''],
        headers: {
          'Content-Type' => 'application/json'
        }
      ).to_return(body: successful_response_json, status: 201)
    end

    subject!(:result) do
      PR::Pin.plans.update(record.token, params)
    end

    it { expect(request_stub).to have_been_requested }
    it { expect(result.success?).to be_truthy }
    it { expect(result.error?).to be_falsey }
    it { expect(result).to eql(updated_record) }
  end

  context 'error response' do
    let(:record) { Factory.structs[:plan] }
    let(:updated_record) do
      Factory.structs[
        :plan, Transformations::Hash.except(record.attributes, record.attributes.keys - param_keys)
      ]
    end
    let(:param_keys) { %i(name) }
    let(:params) { Transformations::Hash.slice(updated_record.attributes, param_keys) }

    context 'reprocessable entity' do
      include_context 'responses.plans.update.error'

      let!(:request_stub) do
        stub_request(
          :put,
          "https://test-api.pinpayments.com/1/plans/#{record.token}"
        ).with(
          body: params,
          basic_auth: [PIN_SECRET_KEY, ''],
          headers: {
            'Content-Type' => 'application/json'
          }
        ).to_return(body: error_response_json, status: 422)
      end

      subject!(:error) do
        PR::Pin.plans.update(record.token, params)
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
          code: 'name_invalid',
          message: "Name can't be blank",
          param: 'name'
        )
      end
    end

    context 'not found' do
      include_context 'responses.not_found'

      let!(:request_stub) do
        stub_request(
          :put,
          "https://test-api.pinpayments.com/1/plans/#{record.token}"
        ).with(
          body: params,
          basic_auth: [PIN_SECRET_KEY, ''],
          headers: {
            'Content-Type' => 'application/json'
          }
        ).to_return(body: error_response_json, status: 404)
      end

      subject!(:error) do
        PR::Pin.plans.update(record.token, params)
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
      it do
        expect(error.messages).to be_empty
      end
    end
  end
end
