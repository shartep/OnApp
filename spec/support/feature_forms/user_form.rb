class UserForm
  include Capybara::DSL

  def visit_index_page
    visit Rails.application.routes.url_helpers.users_path
    self
  end

  def visit_new_page
    visit_index_page
    click_on 'New User'
    self
  end

  def fill_in_with(params = {})
    fill_in 'Email', with: params.fetch(:email, 'default@email.com')
    fill_in 'First name', with: params.fetch(:first_name, 'Default First Name')
    fill_in 'Last name', with: params.fetch(:last_name, 'Default Last Name')
    self
  end

  def submit
    click_on 'Save'
    self
  end

  def click_on_text_near_name(text, name)
    find('td', text: name).find(:xpath, "../td/a[text()='#{text}'][1]").click
    self
  end
end