# frozen_string_literal: true

RSpec.describe Admin::Controllers::Ingredients::Update, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[id: 1, ingredient: {}] }

  it 'redirects to' do
    response = action.call(params)

    expect(response[0]).to eq 302
  end
end
