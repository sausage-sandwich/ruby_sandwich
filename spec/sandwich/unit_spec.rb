# frozen_string_literal: true

RSpec.describe Unit do
  before do
    I18n.locale = :ru
  end

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

  describe '#convert_to_imperial' do
    subject(:in_imperial) { instance.convert_to_imperial }

    shared_examples 'imperial unit' do |unit|
      subject(:in_imperial) { instance.convert_to_imperial }

      let(:instance) { described_class.new(BigDecimal(1), unit) }

      it { expect(in_imperial).to eq instance }
    end

    described_class::TO_METRIC_CONVERSION_RATE.keys.each do |unit|
      it_behaves_like 'imperial unit', unit
    end

    context 'when unit is in kg' do
      let(:instance) { described_class.new(1, :kg) }

      it do
        expect(in_imperial).to have_attributes(
          quantity: be_within(0.01).of(BigDecimal('2.2')),
          unit: :pound
        )
      end
    end

    context 'when unit is in g' do
      let(:instance) { described_class.new(quantity, :g) }

      context 'when quantity is less then 1 pound' do
        let(:quantity) { 453 }

        it do
          expect(in_imperial).to have_attributes(
            quantity: be_within(0.01).of(BigDecimal('15.97')),
            unit: :ounce
          )
        end
      end

      context 'when quantity is more then 1 pound' do
        let(:quantity) { 454 }

        it do
          expect(in_imperial).to have_attributes(
            quantity: be_within(0.01).of(BigDecimal('1')),
            unit: :pound
          )
        end
      end
    end

    context 'when unit is in l' do
      let(:instance) { described_class.new(quantity, :l) }

      context 'when quantity is less then 1 gallon' do
        let(:quantity) { BigDecimal('4.546') }

        it do
          expect(in_imperial).to have_attributes(
            quantity: be_within(0.01).of(BigDecimal('7.99')),
            unit: :pint
          )
        end
      end

      context 'when quantity is more then 1 gallon' do
        let(:quantity) { BigDecimal('4.547') }

        it do
          expect(in_imperial).to have_attributes(
            quantity: be_within(0.01).of(BigDecimal('1')),
            unit: :gallon
          )
        end
      end
    end

    context 'when unit is in ml' do
      let(:instance) { described_class.new(quantity, :ml) }

      context 'when quantity is more or equal then 1 l' do
        let(:quantity) { BigDecimal(1001) }

        it do
          expect(in_imperial).to have_attributes(
            quantity: be_within(0.01).of(BigDecimal('1.76')),
            unit: :pint
          )
        end
      end

      context 'when quantity is between pint and liter' do
        let(:quantity) { BigDecimal(569) }

        it do
          expect(in_imperial).to have_attributes(
            quantity: be_within(0.01).of(BigDecimal('1')),
            unit: :pint
          )
        end
      end

      context 'when quantity is less then pint' do
        let(:quantity) { BigDecimal(567) }

        it do
          expect(in_imperial).to have_attributes(
            quantity: be_within(0.01).of(BigDecimal('19.95')),
            unit: :fluid_ounce
          )
        end
      end
    end
  end

  describe '#humanize' do
    subject(:humanized_unit) { unit.humanize }

    let(:unit) { described_class.new(BigDecimal(10), :fluid_ounce) }

    it 'displays human unit' do
      expect(humanized_unit).to eq '10.0 жидких унций'
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
