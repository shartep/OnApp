require 'rails_helper'

RSpec.describe 'departments/show', type: :view do
  before(:each) do
    assign(:department, create(:department, name: 'Main department'))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Main department/)
  end
end
