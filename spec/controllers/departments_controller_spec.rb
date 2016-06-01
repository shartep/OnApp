require 'rails_helper'

RSpec.describe DepartmentsController, type: :controller do

  let(:long_text) { Array.new(5, 'Name longer then 100 chars').join(', ') }
  let(:department) { create :department }
  let(:valid_attributes) { FactoryGirl.attributes_for :department }
  let(:invalid_attributes) { FactoryGirl.attributes_for :department, name: long_text }
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'renders :index template' do
      get :index, {}, valid_session
      expect(response).to render_template(:index)
    end

    it 'assigns all departments as @departments' do
      dep = department
      get :index, {}, valid_session
      expect(assigns(:departments)).to match_array([dep])
    end
  end

  describe 'GET #show' do
    it 'renders :show template' do
      get :show, { id: department }, valid_session
      expect(response).to render_template(:show)
    end

    it 'assigns the requested department as @department' do
      get :show, { id: department }, valid_session
      expect(assigns(:department)).to eq(department)
    end
  end

  describe 'GET #new' do
    it 'renders :new template' do
      get :new, {}, valid_session
      expect(response).to render_template(:new)
    end

    it 'assigns a new department as @department' do
      get :new, {}, valid_session
      expect(assigns(:department)).to be_a_new(Department)
    end
  end

  describe 'GET #edit' do
    it 'renders :edit template' do
      get :edit, { id: department }, valid_session
      expect(response).to render_template(:edit)
    end

    it 'assigns the requested department as @department' do
      get :edit, { id: department }, valid_session
      expect(assigns(:department)).to eq(department)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Department in the database' do
        expect {
          post :create, { department: valid_attributes }, valid_session
        }.to change(Department, :count).by(1)
      end

      it 'assigns a newly created department as @department' do
        post :create, { department: valid_attributes }, valid_session
        expect(assigns(:department)).to be_a(Department)
        expect(assigns(:department)).to be_persisted
      end

      it 'redirects to the created department' do
        post :create, { department: valid_attributes }, valid_session
        expect(response).to redirect_to(assigns(:department))
      end
    end

    context 'with invalid params' do
      it "doesn't create new department in the database" do
        expect {
          post :create, { department: invalid_attributes }, valid_session
        }.not_to change(Department, :count)
      end

      it 'assigns a newly created but unsaved department as @department' do
        post :create, { department: invalid_attributes }, valid_session
        expect(assigns(:department)).to be_a_new(Department)
      end

      it "re-renders the 'new' template" do
        post :create, { department: invalid_attributes }, valid_session
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { FactoryGirl.attributes_for :department, name: 'Updated department' }

      it 'updates the requested department in database' do
        put :update, { id: department, department: new_attributes}, valid_session
        department.reload
        expect(department.name).to eq('Updated department')
      end

      it 'assigns the requested department as @department' do
        put :update, { id: department, department: new_attributes }, valid_session
        expect(assigns(:department)).to eq(department)
      end

      it 'redirects to the department#show' do
        put :update, { id: department, department: new_attributes }, valid_session
        expect(response).to redirect_to(department)
      end
    end

    context 'with invalid params' do
      it "doesn't update department in the database" do
        put :update, { id: department, department: invalid_attributes }, valid_session
        department.reload
        expect(department.name).not_to eq(long_text)
      end

      it 'assigns the department as @department' do
        put :update, { id: department, department: invalid_attributes }, valid_session
        expect(assigns(:department)).to eq(department)
      end

      it "re-renders the 'edit' template" do
        put :update, { id: department, department: invalid_attributes }, valid_session
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested department' do
      delete :destroy, { id: department }, valid_session
      expect Department.exists?(department.id)
    end

    it 'redirects to the departments#index' do
      delete :destroy, { id: department }, valid_session
      expect(response).to redirect_to(departments_url)
    end
  end

end
