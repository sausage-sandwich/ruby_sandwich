# frozen_string_literal: true

RSpec.describe Unit do
  describe '#convert_to_metric' do
    subject(:converted_unit) { unit.convert_to_metric }

    context 'when unit has a conversion rate' do
      let(:unit) { described_class.new(BigDecimal(10), :fluid_ounce) }

      it 'convertes to metric' do
        expect(converted_unit).to have_attributes(
          quantity: unit.quantity * 28.4131,
          unit: :ml
        )
      end
    end

    context 'when unit has no conversion rate' do
      let(:unit) { described_class.new(BigDecimal(10), :g) }

      it 'does not change' do
        expect(converted_unit).to eq(unit)
      end
    end
  end

  describe '#humanize' do
    subject(:humanized_unit) { unit.humanize }

    let(:unit) { described_class.new(BigDecimal(10), :fluid_ounce) }

    it 'displays human unit' do
      expect(humanized_unit).to eq '10.0 fluid ounce'
    end
  end
end
