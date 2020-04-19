# frozen_string_literal: true

RSpec.describe MacroToEnergy do
  describe '.call' do
    subject(:amount_of_calories) { described_class.call(macro_name, 2000) }

    context 'when carbohydrates' do
      let(:macro_name) { :carbohydrates }

      it 'calculates amount of calories' do
        expect(amount_of_calories).to eq 8
      end
    end

    context 'when fat' do
      let(:macro_name) { :fat }

      it 'calculates amount of calories' do
        expect(amount_of_calories).to eq 18
      end
    end

    context 'when protein' do
      let(:macro_name) { :protein }

      it 'calculates amount of calories' do
        expect(amount_of_calories).to eq 8
      end
    end
  end
end
