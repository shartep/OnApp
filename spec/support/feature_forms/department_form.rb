class DepartmentForm
  include Capybara::DSL

  def visit_index_page
    visit Rails.application.routes.url_helpers.departments_path
    self
  end

  def visit_new_page
    visit_index_page
    click_on 'New Department'
    self
  end

  def fill_in_with(params = {})
    fill_in 'Name', with: params.fetch(:name, 'Default Department')
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