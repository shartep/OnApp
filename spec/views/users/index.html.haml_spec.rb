require 'rails_helper'

RSpec.describe 'users/index', type: :view do
  before(:each) do
    assign(:users, [
      create(:user,
         email: 'email_1@test.com',
         first_name: 'First Name',
         last_name: 'Last Name'
      ),
      create(:user,
         email: 'email_2@test.com',
         first_name: 'First Name',
         last_name: 'Last Name'
      )
    ])
  end

  it 'renders a list of users' do
    render
    assert_select 'tr>td', text: 'email_1@test.com', count: 1
    assert_select 'tr>td', text: 'email_2@test.com', count: 1
    assert_select 'tr>td', text: 'First Name', count: 2
    assert_select 'tr>td', text: 'Last Name', count: 2
  end
end
