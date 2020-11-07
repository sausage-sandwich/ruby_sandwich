# frozen_string_literal: true

RSpec.describe Admin::Views::Users::Index, type: :view do
  let(:exposures) { { users: [] } }
  let(:template) { Hanami::View::Template.new('apps/admin/templates/users/index.html.slim') }
  let(:view) { described_class.new(template, exposures) }
  let(:rendered) { view.render }

  it 'succeeds' do
    expect { rendered }.not_to raise_error
  end
end
