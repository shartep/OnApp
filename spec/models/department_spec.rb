require 'rails_helper'

RSpec.describe Department, type: :model do

  describe 'database' do
    context 'columns' do
      it { should have_db_column(:name).of_type(:string).with_options(null: false) }
    end
  end

  describe 'attributes' do
    it 'has name' do
      expect(build(:department, name: 'Test Name')).to have_attributes(name: 'Test Name')
    end
  end

  describe 'validations' do
    subject { build(:department) }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_length_of(:name).is_at_most(100) }
  end

  describe 'associations' do
    it { should have_many(:issues) }
  end

end
