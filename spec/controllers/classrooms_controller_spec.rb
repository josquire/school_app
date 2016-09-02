require 'rails_helper'

RSpec.describe ClassroomsController, type: :controller do

  describe "GET #show" do
    before(:each) do
      @school = FactoryGirl.create(:school)
      @school_id = @school[:id]
      @classroom = FactoryGirl.create(:classroom, school_id: @school_id)
      get :show, params: {school_id: @school.id, id: @classroom.id}
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "set the classroom instance variable" do
      expect(assigns(:classroom)).to eq(@classroom)
    end

    it "renders the show template" do
      expect(response).to render_template(:show)
    end
  end


  describe "GET #new" do
    before(:each) do
      @school = FactoryGirl.create(:school)
      @school_id = @school[:id]
      get :new, params: {school_id: @school.id}
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "sets a new instance of classroom" do
      expect(assigns(:classroom).class).to eq(Classroom)
    end

    it "renders a new template" do
      expect(response).to render_template(:new)
    end
  end


  describe "GET #edit" do
    before(:each) do
      @school = FactoryGirl.create(:school)
      @school_id = @school[:id]
      @classroom = FactoryGirl.create(:classroom, school_id: @school_id)
      get :edit, params: {school_id: @school.id, id: @classroom.id}
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "sets the classroom instance variable" do
      expect(assigns(:classroom)).to eq(@classroom)
    end

    it "renders the edit template" do
      expect(response).to render_template(:edit)
    end
  end


  describe "POST #create" do
    before(:each) do
      @school = FactoryGirl.create(:school)
    end

    context 'valid params' do
      before(:each)do
      @classroom_params = {teacher: 'white', grade: '4', number_students: '34'}
      post :create, params: {school_id: @school.id, classroom: @classroom_params}
    end

      it "creates a classroom successfully" do
        expect(Classroom.count).to eq(1)
      end

      it "redirect to the show on success" do
        expect(response).to redirect_to school_path(@school.id)
      end
    end

    context 'invald params'do
      it "render the new template on fail" do
        @classroom_params = {teacher: '', grade: '4', number_students: '34'}
        post :create, params: {school_id: @school.id, classroom: @classroom_params}
        expect(response).to render_template(:new)
      end
    end
  end


  describe "PUT #update" do
    before(:each) do
      @school = FactoryGirl.create(:school)
      @school_id = @school[:id]
      @classroom = FactoryGirl.create(:classroom, school_id: @school_id)
    end

    context 'sucessful update' do
      before(:each)do
      classroom_params = {teacher: 'new'}
      put :update, params: {school_id: @school.id, id: @classroom.id, classroom: classroom_params}
      end

      it "updates classrooms successfully" do
        expect(@classroom.reload.teacher).to eq('new')
      end

      it "redirects to the classroom show on update" do
        expect(response).to redirect_to school_classroom_path(@school, @classroom)
      end
    end

    context 'unsuccessful update' do
      it "renders the edit template on fail" do
        classroom_params = {teacher: '', grade: '4', number_students: '34'}
        put :update, params: {school_id: @school.id, id: @classroom.id, classroom: classroom_params}
        expect(response).to render_template(:edit)
      end
    end
  end


  describe "DELETE #destroy" do
    before(:each) do
      @school = FactoryGirl.create(:school)
      @school_id = @school[:id]
      @classroom = FactoryGirl.create(:classroom, school_id: @school_id)
      @classroom_params = {teacher: 'white', grade: '4', number_students: '34'}
      delete :destroy, params: {school_id: @school.id, id: @classroom.id, classroom: @classroom_params}
    end

    it "successfully deletes a classroom" do
      expect(Classroom.count).to eq(0)
    end

    it "redirects to the countries path on success" do
      expect(response).to redirect_to school_path(@school.id)
    end
  end
end
