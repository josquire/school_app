require 'rails_helper'

RSpec.describe SchoolsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'set the schools instance variable' do
      get :index
      expect(assigns(:schools)).to eq([])
    end

    it 'has schools in the instance variable' do
      School.create(name: 'test', level: '4', student_body: '200')
      get :index
      expect(assigns(:schools).length).to eq(1)
      expect(assigns(:schools).first.name).to eq('test')
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      school = School.create(name: 'test', level: '4', student_body: '200')
      get :show, id: school.id
      expect(response).to have_http_status(:success)
    end

    it "set the school instance variable" do
      school = School.create(name: 'test', level: '4', student_body: '200')
      get :show, id: school.id
      expect(assigns(:school)).to eq(school)
    end

    it "renders the show template" do
      school = School.create(name: 'test', level: '4', student_body: '200')
      get :show, id: school
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "sets the school instance variable" do
      get :new
      expect(assigns(:school).class).to eq(School)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      school = School.create(name: 'test', level: '4', student_body: '200')
      get :edit, id: school
      expect(response).to have_http_status(:success)
    end

    it "set the school instance variabe" do
      school = School.create(name: 'test', level: '4', student_body: '200')
      get :edit, id: school
      expect(assigns(:school)).to eq(school)
    end

    it "renders the edit template" do
      school = School.create(name: 'test', level: '4', student_body: '200')
      get :edit, id: school
      expect(response).to render_template(:edit)
    end
  end

  describe "POST #create" do
    it "successfully creates a school" do
      school_params = {school: {name: 'test', level: '5', student_body: '34'}}
      post :create, school_params
      expect(School.count).to eq(1)
      expect(School.first.name).to eq(school_params[:school][:name])
    end

    it "renders the new template on unsuccessful create" do
      school_params = {school: {name: '', level: '6', student_body: '34'}}
      post :create, school_params
      expect(School.count).to eq(0)
      expect(response).to render_template(:new)
    end

    it "redirects to the school path on sucess" do
      school_params = {school: {name: 'test', level: '', student_body: '34'}}
      post :create, school_params
      expect(response).to redirect_to school_path(School.first)
    end
  end

  describe "PUT #update" do
    it "successfully updates a school" do
      school = School.create(name: 'test', level: '4', student_body: '200')
      school_params = {name: 'updated by test'}
      put :update, {id: school.id, school: school_params}
      expect(school.reload.name).to eq('updated by test')
    end

    it "redirects to the country path on success" do
      school = School.create(name: 'test', level: '4', student_body: '200')
      school_params = {name: 'updated by test'}
      put :update, {id: school.id, school: school_params}
      expect(response).to redirect_to school_path(School.first)
    end

    it "renders the edit template on fail" do
      school = School.create(name: 'test', level: '4', student_body: '200')
      school_params = {name: ''}
      put :update, {id: school.id, school: school_params}
      expect(response).to render_template(:edit)
    end
  end

    describe "DELETE #destroy" do
      it "successfully deletes a school" do
      school = School.create(name: 'test', level: '4', student_body: '200')
      expect(School.count).to eq(1)
      delete :destroy, id: school.id
      expect(School.count).to eq(0)
    end

    it "redirects to the schools path on success" do
      school = School.create(name: 'test', level: '4', student_body: '200')
      delete :destroy, id: school.id
      expect(response).to redirect_to schools_path
    end
  end

end
