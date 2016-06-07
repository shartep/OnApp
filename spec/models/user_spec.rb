require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'database' do
    context 'columns' do
      it { should have_db_column(:first_name).of_type(:string) }
      it { should have_db_column(:last_name).of_type(:string) }
      it { should have_db_column(:email).of_type(:string) }
    end
  end

  describe 'attributes' do
    it 'has name' do
      expect(build(:user, first_name: 'First Name')).to have_attributes(first_name: 'First Name')
      expect(build(:user, last_name: 'Last Name')).to have_attributes(last_name: 'Last Name')
      expect(build(:user, email: 'email@test.com')).to have_attributes(email: 'email@test.com')
    end
  end

  describe 'validations' do
    subject { build(:user) }

    it { should validate_presence_of(:first_name) }
    it { should validate_length_of(:first_name).is_at_most(100) }
    it { should validate_presence_of(:last_name) }
    it { should validate_length_of(:last_name).is_at_most(100) }

    it { should validate_presence_of(:email) }
    it { should validate_email_format_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end

  describe 'associations' do
    it { should have_many(:issues) }
  end

end
