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
    before(:each) do
      @school = FactoryGirl.create(:school)
      get :show, params: {id: @school.id}
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "set the school instance variable" do
      expect(assigns(:school)).to eq(@school)
    end

    it "renders the show template" do
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    before(:each) do
      get :new
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "sets the school instance variable" do
      expect(assigns(:school).class).to eq(School)
    end

    it "renders the new template" do
      expect(response).to render_template(:new)
    end
  end

  describe "GET #edit" do
    before(:each) do
      @school = FactoryGirl.create(:school)
      get :edit, params: {id: @school.id}
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "set the school instance variabe" do
      expect(assigns(:school)).to eq(@school)
    end

    it "renders the edit template" do
      expect(response).to render_template(:edit)
    end
  end

  describe "POST #create" do
    before(:each) do
      @school_params = {name: 'test', level: '5', student_body: '34'}
    end

    context 'valid params' do
      before(:each) do
        post :create, params: {school: @school_params}
      end

      it "sets the instance variable" do
        expect(assigns(:school).name).to eq('test')
      end

      it "successfully creates a school" do
        expect(School.count).to eq(1)
        expect(School.first.name).to eq('test')
      end

      it "redirects to the school path on sucess" do
        expect(response).to redirect_to school_path(School.first)
      end
    end

    context 'with invalid params' do
      it "renders the new template on fail" do
        @school_params[:name] = ''
        post :create, params: {school: @school_params}
        expect(School.count).to eq(0)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PUT #update" do
    before(:each) do
      @school = FactoryGirl.create(:school)
      @school_params = {name: 'updated by test'}
    end

    context 'valid params' do
      before(:each) do
        put :update, params: {id: @school.id, school: @school_params}
      end

      it "successfully updates a school" do
        expect(@school.reload.name).to eq(@school_params[:name])
      end

      it "redirects to the country path on success" do
        expect(response).to redirect_to school_path(@school)
      end
    end

    context 'invalid params' do
      it "renders the edit template on fail" do
        @school_params[:name] = ''
        put :update, params: { id: @school.id, school: @school_params}
        expect(response).to render_template(:edit)
        expect(@school.reload.name).to eq('skyridge')
      end
    end
  end

    describe "DELETE #destroy" do
      before(:each) do
        @school = FactoryGirl.create(:school)
        delete :destroy, params: {id: @school.id}
      end

    it "sets the school instance variable" do
      expect(assigns(:school)).to eq(@school)
    end

    it "successfully deletes a school" do
      expect(School.count).to eq(0)
    end

    it "redirects to the schools path on success" do
      expect(response).to redirect_to schools_path
    end
  end

end
