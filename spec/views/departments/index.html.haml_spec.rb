require 'rails_helper'

RSpec.describe 'departments/index', type: :view do
  before(:each) do
    assign(:departments, [
      create(:department, name: 'Main department'),
      create(:department, name: 'First department')
    ])
  end

  it 'renders a list of departments' do
    render
    assert_select 'tr>td', text: 'Main department'.to_s, count: 1
    assert_select 'tr>td', text: 'First department'.to_s, count: 1
  end
end
