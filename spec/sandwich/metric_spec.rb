# frozen_string_literal: true

RSpec.describe Metric do
  describe 'mg_to_g' do
    subject(:weight_in_grams) { described_class.mg_to_g(1000) }

    it 'converts milligrams to grams' do
      expect(weight_in_grams).to eq 1
    end
  end
end
