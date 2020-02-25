RSpec.shared_examples_for 'a_paginated_response' do
  let(:params) do
    {
      page: page,
      per_page: per_page
    }
  end
  let(:page) { 1 }
  let(:per_page) { 3 }
  let(:total_count) { 7 }
  let(:total_pages) { (total_count / per_page.to_f).ceil }
  let(:records) do
    Array.new(total_count) { Factory.structs[:charge] }
  end
  let(:successful_responses) do
    Array.new(total_pages) do |page|
      {
        response: records.drop(page * per_page).take(per_page).map { |record|
          representer.(record)
        },
        count: total_count,
        pagination: {
          current: page.next,
          per_page: per_page,
          pages: total_pages,
          count: total_count
        }
      }
    end
  end

  describe '#each_page' do
    context 'with multiple pages to fetch' do
      let!(:pages) { [] }
      let!(:request_stubs) do
        Array.new(total_pages) do |page|
          stub_request(:get, uri).with(
            query: params.merge(page: page.next),
            basic_auth: [PIN_SECRET_KEY, ''],
            headers: {
              'Content-Type' => 'application/json'
            }
          ).to_return(
            body: JSON.dump(successful_responses[page]),
            status: 200
          )
        end
      end

      subject! do
        base_result.each_page do |page|
          pages << page
        end
      end

      it do
        request_stubs.each do |request_stub|
          expect(request_stub).to have_been_requested
        end
      end

      it do
        total_pages.times do |page|
          expect(pages[page]).to eq(
            records.drop(page * per_page).take(per_page)
          )
        end
      end
    end

    context 'without multiple pages to fetch' do
      let(:total_count) { per_page }
      let!(:pages) { [] }
      let!(:request_stub) do
        stub_request(:get, uri).with(
          query: params,
          basic_auth: [PIN_SECRET_KEY, ''],
          headers: {
            'Content-Type' => 'application/json'
          }
        ).to_return(
          body: JSON.dump(successful_responses[0]),
          status: 200
        )
      end

      subject! do
        base_result.each_page do |page|
          pages << page
        end
      end

      it { expect(request_stub).to have_been_requested }
      it { expect(pages[0]).to eq(records) }
      it { expect(pages.length).to eq(1) }
    end
  end

  describe '#pages' do
    context 'with multiple pages to fetch' do
      let!(:request_stubs) do
        Array.new(total_pages) do |page|
          stub_request(:get, uri).with(
            query: params.merge(page: page.next),
            basic_auth: [PIN_SECRET_KEY, ''],
            headers: {
              'Content-Type' => 'application/json'
            }
          ).to_return(
            body: JSON.dump(successful_responses[page]),
            status: 200
          )
        end
      end

      subject!(:pages) do
        base_result.pages
      end

      it do
        request_stubs.each do |request_stub|
          expect(request_stub).to have_been_requested
        end
      end

      it do
        total_pages.times do |page|
          expect(pages[page]).to eq(
            records.drop(page * per_page).take(per_page)
          )
        end
      end
    end

    context 'without multiple pages to fetch' do
      let(:total_count) { per_page }
      let!(:request_stub) do
        stub_request(:get, uri).with(
          query: params,
          basic_auth: [PIN_SECRET_KEY, ''],
          headers: {
            'Content-Type' => 'application/json'
          }
        ).to_return(
          body: JSON.dump(successful_responses[0]),
          status: 200
        )
      end

      subject!(:pages) do
        base_result.pages
      end

      it { expect(request_stub).to have_been_requested }
      it { expect(pages[0]).to eq(records) }
      it { expect(pages.length).to eq(1) }
    end
  end
end
