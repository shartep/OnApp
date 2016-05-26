require 'rails_helper'

RSpec.describe "issues/index", type: :view do
  before(:each) do
    assign(:issues, [
      Issue.create!(
        :subject => "Subject",
        :body => "MyText",
        :department => nil,
        :user => nil
      ),
      Issue.create!(
        :subject => "Subject",
        :body => "MyText",
        :department => nil,
        :user => nil
      )
    ])
  end

  it "renders a list of issues" do
    render
    assert_select "tr>td", :text => "Subject".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
