# frozen_string_literal: true

RSpec.describe GenerateSalad do
  subject(:generate_salad) { described_class.new.call }

  let(:available_ingredients) { described_class::INGREDIENTS.values.flatten }

  it { expect(generate_salad).to be_success }

  it 'generates salad' do
    expect(available_ingredients).to include(*generate_salad.ingredients)
  end

  context 'with selected categories' do
    subject(:generate_salad) { described_class.new.call(categories: categories) }

    let(:categories) { described_class::INGREDIENTS.keys.sample(2) }
    let(:available_ingredients) { described_class::INGREDIENTS.values_at(*categories).flatten }

    it 'construct within selected categories' do
      expect(available_ingredients).to include(*generate_salad.ingredients)
    end
  end

  context 'with no categories' do
    subject(:generate_salad) { described_class.new.call(categories: categories) }

    let(:categories) { [] }

    it 'construct within selected categories' do
      expect(generate_salad.ingredients).to eq []
    end
  end
end
