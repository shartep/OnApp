require 'rails_helper'

RSpec.describe 'User features' do

  VALID_EMAIL = 'valid@email.com'
  INVALID_EMAIL = 'invalid#emailcom'

  let(:long_text) { Array.new(5, 'Name longer then 100 chars').join(', ') }
  let(:form) { UserForm.new }
  let(:user) { create :user }

  feature 'User create another User' do
    scenario 'with valid params' do
      form.visit_new_page.fill_in_with(email: VALID_EMAIL).submit

      expect(page).to have_content('User was successfully created.')
      expect(page).to have_content("Email: #{VALID_EMAIL}")
      expect(User.last.email).to eq(VALID_EMAIL)
    end

    scenario 'with same email' do
      form.visit_new_page.fill_in_with(email: user.email).submit

      expect(page).to have_content('New user')
      within '#error_explanation' do
        expect(page).to have_content('1 error prohibited this user from being saved:')
        expect(page).to have_content('Email has already been taken')
      end
    end

    scenario 'with empty email' do
      form.visit_new_page.fill_in_with(email: '').submit

      expect(page).to have_content('New user')
      within '#error_explanation' do
        expect(page).to have_content('2 errors prohibited this user from being saved:')
        expect(page).to have_content("Email can't be blank")
        expect(page).to have_content('Email does not appear to be a valid e-mail address')
      end
    end

    scenario 'with invalid email format' do
      form.visit_new_page.fill_in_with(email: INVALID_EMAIL).submit

      expect(page).to have_content('New user')
      within '#error_explanation' do
        expect(page).to have_content('1 error prohibited this user from being saved:')
        expect(page).to have_content('Email does not appear to be a valid e-mail address')
      end
    end

    scenario 'with long name' do
      form.visit_new_page.fill_in_with(first_name: long_text ).submit

      expect(page).to have_content('New user')
      within '#error_explanation' do
        expect(page).to have_content('1 error prohibited this user from being saved:')
        expect(page).to have_content('First name is too long (maximum is 100 characters)')
      end
    end
  end

  feature 'User open view page' do
    scenario 'of exist User' do
      user_email = user.email
      form.visit_index_page.click_on_text_near_name('Show', user_email)

      expect(page).to have_content(user_email)
    end

    scenario 'of non-exist User' do
      expect {
        form.visit_index_page.click_on_text_near_name('Show', VALID_EMAIL)
      }.to raise_exception(Capybara::ElementNotFound)
    end
  end

  feature 'User update other User' do
    scenario 'with valid email' do
      user_email = user.email
      form.visit_index_page.click_on_text_near_name('Edit', user_email).fill_in_with(email: VALID_EMAIL).submit

      expect(page).to have_content('User was successfully updated.')
      expect(page).to have_content("Email: #{VALID_EMAIL}")
      user.reload
      expect(user.email).to eq(VALID_EMAIL)
    end

    scenario 'with invalid email' do
      user_email = user.email
      form.visit_index_page.click_on_text_near_name('Edit', user_email).fill_in_with(email: INVALID_EMAIL).submit

      expect(page).to have_content('Editing user')
      within '#error_explanation' do
        expect(page).to have_content('1 error prohibited this user from being saved:')
        expect(page).to have_content('Email does not appear to be a valid e-mail address')
      end
    end

    scenario 'with name longer than 100 chars' do
      user_email = user.email
      form.visit_index_page.click_on_text_near_name('Edit', user_email).fill_in_with(last_name: long_text).submit

      expect(page).to have_content('Editing user')
      within '#error_explanation' do
        expect(page).to have_content('1 error prohibited this user from being saved:')
        expect(page).to have_content('Last name is too long (maximum is 100 characters)')
      end
    end
  end

  feature 'User delete another User', js: true do
    scenario 'with confirmation' do
      user_email = user.email
      form.visit_index_page.click_on_text_near_name('Destroy', user_email)
      page.driver.browser.switch_to.alert.accept

      expect {
        form.visit_index_page.click_on_text_near_name('Destroy', user_email)
      }.to raise_exception(Capybara::ElementNotFound)
      expect(User.find_by_email(user_email)).to be_nil
    end

    scenario 'without confirmation', js: true do
      user_email = user.email
      form.visit_index_page.click_on_text_near_name('Destroy', user_email)
      page.driver.browser.switch_to.alert.dismiss

      expect(page).to have_content(user_email)
      expect(User.find_by_email(user_email)).to eq(user)
    end
  end

end