require 'rails_helper'

RSpec.describe 'users/new', type: :view do
  before(:each) do
    assign(:user, build(:user,
        email: 'email@test.com',
        first_name: 'First Name',
        last_name: 'Last Name')
    )
  end

  it 'renders new user form' do
    render
    assert_select 'form[action=?][method=?]', users_path, 'post' do
      assert_select 'input#user_email[name=?]', 'user[email]'
      assert_select 'input#user_first_name[name=?]', 'user[first_name]'
      assert_select 'input#user_last_name[name=?]', 'user[last_name]'
    end
  end
end
