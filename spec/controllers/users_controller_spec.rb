require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:user) { create :user }
  let(:valid_attributes) { attributes_for :user }
  let(:invalid_attributes) { attributes_for :user, email: 'invalid#emailcom' }
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'renders :index template' do
      get :index, {}, valid_session
      expect(response).to render_template(:index)
    end

    it 'assigns all users as @users' do
      u = user
      get :index, {}, valid_session
      expect(assigns(:users)).to eq([u])
    end
  end

  describe 'GET #show' do
    it 'renders :show template' do
      get :show, { id: user }, valid_session
      expect(response).to render_template(:show)
    end

    it 'assigns the requested user as @user' do
      get :show, { id: user }, valid_session
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'GET #new' do
    it 'renders :new template' do
      get :new, {}, valid_session
      expect(response).to render_template(:new)
    end

    it 'assigns a new user as @user' do
      get :new, {}, valid_session
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'GET #edit' do
    it 'renders :edit template' do
      get :edit, { id: user }, valid_session
      expect(response).to render_template(:edit)
    end

    it 'assigns the requested user as @user' do
      get :edit, { id: user }, valid_session
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new User in the database' do
        expect {
          post :create, { user: valid_attributes }, valid_session
        }.to change(User, :count).by(1)
      end

      it 'assigns a newly created user as @user' do
        post :create, { user: valid_attributes }, valid_session
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end

      it 'redirects to the created user' do
        post :create, { user: valid_attributes }, valid_session
        expect(response).to redirect_to(User.last)
      end
    end

    context 'with invalid params' do
      it "doesn't create new user in the database" do
        expect {
          post :create, { user: invalid_attributes }, valid_session
        }.not_to change(User, :count)
      end

      it 'assigns a newly created but unsaved user as @user' do
        post :create, { user: invalid_attributes }, valid_session
        expect(assigns(:user)).to be_a_new(User)
      end

      it "re-renders the 'new' template" do
        post :create, { user: invalid_attributes }, valid_session
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { attributes_for :user, email: 'udated@email.com' }

      it 'updates the requested user in database' do
        put :update, { id: user, user: new_attributes }, valid_session
        user.reload
        expect(user.email).to eq('udated@email.com')
      end

      it 'assigns the requested user as @user' do
        put :update, { id: user, user: new_attributes }, valid_session
        expect(assigns(:user)).to eq(user)
      end

      it 'redirects to the user#show' do
        put :update, { id: user, user: new_attributes }, valid_session
        expect(response).to redirect_to(user)
      end
    end

    context 'with invalid params' do
      it "doesn't update user in the database" do
        put :update, { id: user, user: invalid_attributes }, valid_session
        user.reload
        expect(user.email).not_to eq('invalid#emailcom')
      end

      it 'assigns the user as @user' do
        put :update, { id: user, user: invalid_attributes }, valid_session
        expect(assigns(:user)).to eq(user)
      end

      it "re-renders the 'edit' template" do
        put :update, { id: user, user: invalid_attributes }, valid_session
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested user' do
      u_id = user.id
      expect {
        delete :destroy, { id: u_id }, valid_session
      }.to change(User, :count).by(-1)
    end

    it 'redirects to the users#index' do
      delete :destroy, { id: user }, valid_session
      expect(response).to redirect_to(users_url)
    end
  end

end
