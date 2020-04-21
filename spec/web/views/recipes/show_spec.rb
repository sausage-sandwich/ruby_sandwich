# frozen_string_literal: true

RSpec.describe Web::Views::Recipes::Show, type: :view do
  let(:exposures) { Hash[format: :html] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/recipes/show.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #format' do
    expect(view.format).to eq exposures.fetch(:format)
  end

  it 'presents nutrient in grams' do
    value = view.nutrient(1000)

    expect(value).to eq '1 g'
  end
end
