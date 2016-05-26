require 'rails_helper'

RSpec.describe "issues/new", type: :view do
  before(:each) do
    assign(:issue, Issue.new(
      :subject => "MyString",
      :body => "MyText",
      :department => nil,
      :user => nil
    ))
  end

  it "renders new issue form" do
    render

    assert_select "form[action=?][method=?]", issues_path, "post" do

      assert_select "input#issue_subject[name=?]", "issue[subject]"

      assert_select "textarea#issue_body[name=?]", "issue[body]"

      assert_select "input#issue_department_id[name=?]", "issue[department_id]"

      assert_select "input#issue_user_id[name=?]", "issue[user_id]"
    end
  end
end
