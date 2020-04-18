# frozen_string_literal: true

RSpec.describe Web::Views::Recipes::New, type: :view do
  let(:exposures) { { format: :html, recipe: recipe, params: {} } }
  let(:recipe) { double(:recipe, title: 'title', body: 'body', recipe_ingredients: []) }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/recipes/new.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #format' do
    expect(view.format).to eq exposures.fetch(:format)
    expect(rendered).to be
  end
end
