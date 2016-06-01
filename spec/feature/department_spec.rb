require 'rails_helper'

RSpec.describe 'Departments features' do

  VALID_NAME = 'Main Department'

  let(:long_text) { Array.new(5, 'Name longer then 100 chars').join(', ') }
  let(:department_form) { DepartmentForm.new }
  let(:department) { create :department }

  feature 'User create a Department' do
    scenario 'with valid name' do
      department_form.visit_new_page.fill_in_with(name: VALID_NAME).submit

      expect(page).to have_content('Department was successfully created.')
      expect(page).to have_content("Name: #{VALID_NAME}")
      expect(Department.last.name).to eq(VALID_NAME)
    end

    scenario 'with same name' do
      department_form.visit_new_page.fill_in_with(name: department.name).submit

      expect(page).to have_content('New department')
      within '#error_explanation' do
        expect(page).to have_content('1 error prohibited this department from being saved:')
        expect(page).to have_content('Name has already been taken')
      end
    end

    scenario 'with empty name' do
      department_form.visit_new_page.fill_in_with(name: '').submit

      expect(page).to have_content('New department')
      within '#error_explanation' do
        expect(page).to have_content('1 error prohibited this department from being saved:')
        expect(page).to have_content("Name can't be blank")
      end
    end

    scenario 'with long name' do
      department_form.visit_new_page.fill_in_with(name: long_text ).submit

      expect(page).to have_content('New department')
      within '#error_explanation' do
        expect(page).to have_content('1 error prohibited this department from being saved:')
        expect(page).to have_content('Name is too long (maximum is 100 characters)')
      end
    end
  end

  feature 'User open view page' do
    scenario 'of exist Department' do
      dep_name = department.name
      department_form.visit_index_page.click_on_text_near_name('Show', dep_name)

      expect(page).to have_content(dep_name)
    end

    scenario 'of non-exist Department' do
      expect {
        department_form.visit_index_page.click_on_text_near_name('Show', VALID_NAME)
      }.to raise_exception(Capybara::ElementNotFound)
    end
  end

  feature 'User update Department' do
    scenario 'with valid name' do
      dep_name = department.name
      department_form.visit_index_page.click_on_text_near_name('Edit', dep_name).fill_in_with(name: VALID_NAME).submit

      expect(page).to have_content('Department was successfully updated.')
      expect(page).to have_content("Name: #{VALID_NAME}")
      department.reload
      expect(department.name).to eq(VALID_NAME)
    end

    scenario 'with name longer than 100 chars' do
      dep_name = department.name
      department_form.visit_index_page.click_on_text_near_name('Edit', dep_name).fill_in_with(name: long_text).submit

      expect(page).to have_content('Editing department')
      within '#error_explanation' do
        expect(page).to have_content('1 error prohibited this department from being saved:')
        expect(page).to have_content('Name is too long (maximum is 100 characters)')
      end
    end
  end

  feature 'User delete Department', js: true do
    scenario 'with confirmation' do
      dep_name = department.name
      department_form.visit_index_page.click_on_text_near_name('Destroy', dep_name)
      page.driver.browser.switch_to.alert.accept

      expect {
        department_form.visit_index_page.click_on_text_near_name('Destroy', dep_name)
      }.to raise_exception(Capybara::ElementNotFound)
      expect(Department.find_by_name(dep_name)).to be_nil
    end

    scenario 'without confirmation', js: true do
      dep_name = department.name
      department_form.visit_index_page.click_on_text_near_name('Destroy', dep_name)
      page.driver.browser.switch_to.alert.dismiss

      expect(page).to have_content(dep_name)
      expect(Department.find_by_name(dep_name)).to eq(department)
    end
  end

end