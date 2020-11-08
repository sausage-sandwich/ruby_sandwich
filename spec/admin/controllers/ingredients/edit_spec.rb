# frozen_string_literal: true

RSpec.describe Admin::Controllers::Ingredients::Edit, type: :action do
  it_behaves_like 'non admin user in admin controllers'

  let(:action) { described_class.new }
  let(:params) { {} }

  context 'when admin signed in' do
    include_context 'signed in admin'

    it 'is successful' do
      expect(subject[0]).to eq 200
    end
  end
end
