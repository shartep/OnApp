require 'rails_helper'

RSpec.describe "issues/edit", type: :view do
  before(:each) do
    @issue = assign(:issue, Issue.create!(
      :subject => "MyString",
      :body => "MyText",
      :department => nil,
      :user => nil
    ))
  end

  it "renders the edit issue form" do
    render

    assert_select "form[action=?][method=?]", issue_path(@issue), "post" do

      assert_select "input#issue_subject[name=?]", "issue[subject]"

      assert_select "textarea#issue_body[name=?]", "issue[body]"

      assert_select "input#issue_department_id[name=?]", "issue[department_id]"

      assert_select "input#issue_user_id[name=?]", "issue[user_id]"
    end
  end
end
