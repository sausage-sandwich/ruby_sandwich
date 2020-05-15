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

  describe '#convert_to_grams' do
    let(:quantity) { 100 }

    shared_examples 'can be converted to grams' do |unit|
      subject(:in_grams) { described_class.new(quantity, unit).convert_to_grams }

      context "when unit is #{unit}" do
        it 'converts' do
          expect(in_grams).to have_attributes(quantity: BigDecimal(result_quantity), unit: :g)
        end
      end
    end

    shared_examples "can't be converted to grams" do |unit|
      subject(:in_grams) { described_class.new(quantity, unit).convert_to_grams }

      context "when unit is #{unit}" do
        it do
          expect { in_grams }.to raise_error described_class::ConversionError
        end
      end
    end

    it_behaves_like 'can be converted to grams', :g do
      let(:result_quantity) { quantity }
    end

    it_behaves_like 'can be converted to grams', :kg do
      let(:result_quantity) { BigDecimal(quantity * 1000) }
    end

    it_behaves_like 'can be converted to grams', :ounce do
      let(:result_quantity) { BigDecimal(quantity) * BigDecimal('28.3495') }
    end

    it_behaves_like 'can be converted to grams', :pound do
      let(:result_quantity) { BigDecimal(quantity) * BigDecimal('453.592') }
    end

    it_behaves_like "can't be converted to grams", :gallon
    it_behaves_like "can't be converted to grams", :quart
    it_behaves_like "can't be converted to grams", :pint
    it_behaves_like "can't be converted to grams", :fluid_ounce
  end
end
