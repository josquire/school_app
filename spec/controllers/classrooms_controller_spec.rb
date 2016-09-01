require 'rails_helper'

RSpec.describe ClassroomsController, type: :controller do
#not working
  describe "GET #show" do
    it "returns http success" do
      school = School.create(name: 'test', level: '4', student_body: '3455')
      classroom = Classroom.create(teacher: 'white', grade: '4', number_students: '34', school_id: school.id)
      get :show, params: {school_id: school.id, id: classroom.id}
      expect(response).to have_http_status(:success)
    end

    it "set the classroom instance variable" do
      school = School.create(name: 'test', level: '4', student_body: '3455')
      classroom = Classroom.create(teacher: 'white', grade: '4', number_students: '34', school_id: school.id)
      get :show, params: {school_id: school.id, id: classroom.id}
      expect(assigns(:classroom)).to eq(classroom)
    end

    it "renders the show template" do
      school = School.create(name: 'test', level: '4', student_body: '3455')
      classroom = Classroom.create(teacher: 'white', grade: '4', number_students: '34', school_id: school.id)
      get :show, params: {school_id: school.id, id: classroom.id}
      expect(response).to render_template(:show)
    end
  end


  describe "GET #new" do
    it "returns http success" do
      school = School.create(name: 'test', level: '4', student_body: '3455')
      get :new, params: {school_id: school.id}
      expect(response).to have_http_status(:success)
    end

    it "sets a new instance of classroom" do
      school = School.create(name: 'test', level: '4', student_body: '3455')
      get :new, params: {school_id: school.id}
      expect(assigns(:classroom).class).to eq(Classroom)
    end

    it "renders a new template" do
      school = School.create(name: 'test', level: '4', student_body: '3455')
      get :new, params: {school_id: school.id}
      expect(response).to render_template(:new)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      school = School.create(name: 'test', level: '4', student_body: '3455')
      classroom = Classroom.create(teacher: 'white', grade: '4', number_students: '34', school_id: school.id)
      get :edit, params: {school_id: school.id, id: classroom.id}
      expect(response).to have_http_status(:success)
    end

    it "sets the classroom instance variable" do
      school = School.create(name: 'test', level: '4', student_body: '3455')
      classroom = Classroom.create(teacher: 'white', grade: '4', number_students: '34', school_id: school.id)
      get :edit, params: {school_id: school.id, id: classroom.id}
      expect(assigns(:classroom)).to eq(classroom)
    end

    it "renders the edit template" do
      school = School.create(name: 'test', level: '4', student_body: '3455')
      classroom = Classroom.create(teacher: 'white', grade: '4', number_students: '34', school_id: school.id)
      get :edit, params: {school_id: school.id, id: classroom.id}
      expect(response).to render_template(:edit)
    end
  end


  describe "POST #create" do
    it "creates a classroom successfully" do
      school = School.create(name: 'test', level: '4', student_body: '3455')
      classroom_params = {teacher: 'white', grade: '4', number_students: '34'}
      post :create, params: {school_id: school.id, classroom: classroom_params}
      expect(Classroom.count).to eq(1)
    end

    it "redirect to the show on success" do
      school = School.create(name: 'test', level: '4', student_body: '3455')
      classroom_params = {teacher: 'white', grade: '4', number_students: '34'}
      post :create, params: {school_id: school.id, classroom: classroom_params}
      expect(response).to redirect_to school_path(school.id)
    end

    it "render the new template on fail" do
      school = School.create(name: 'test', level: '4', student_body: '3455')
      classroom_params = {teacher: '', grade: '4', number_students: '34'}
      post :create, params: {school_id: school.id, classroom: classroom_params}
      expect(response).to render_template(:new)
    end
  end

#not working
  describe "PUT #update" do

    it "updates classrooms successfully" do
      school = School.create(name: 'test', level: '4', student_body: '3455')
      classroom = Classroom.create(teacher: 'white', grade: '4', number_students: '34', school_id: school.id)
      classroom_params = {teacher: 'new'}
      put :update, params: {school_id: school.id, classroom: classroom_params}
      expect(classroom.reload.teacher).to eq('new')
    end

    it "redirects to the classroom show on update" do
      school = School.create(name: 'test', level: '4', student_body: '3455')
      classroom_params = {teacher: 'white', grade: '4', number_students: '34'}
      put :update, params: {school_id: school.id, classroom: classroom_params}
      expect(response).to redirect_to school_path(school.id)
    end

    it "renders the edit template on fail" do
      school = School.create(name: 'test', level: '4', student_body: '3455')
      classroom_params = {teacher: 'white', grade: '4', number_students: '34'}
      put :update, params: {school_id: school.id, classroom: classroom_params}
      expect(response).to render_template(:edit)
    end
  end

  describe "DELETE #destroy" do

    it "successfully deletes a classroom" do
      school = School.create(name: 'test', level: '4', student_body: '3455')
      classroom = Classroom.create(teacher: 'white', grade: '4', number_students: '34', school_id: school.id)
      delete :destroy, params: {school_id: school.id, classroom: classroom_id}
      expect(Classroom.count).to eq(0)
    end

    it "redirects to the countries path on success" do
      school = School.create(name: 'test', level: '4', student_body: '3455')
      classroom = Classroom.create(teacher: 'white', grade: '4', number_students: '34', school_id: school.id)
      delete :destroy, params: {school_id: school.id, classroom: classroom_id}
      expect(response).to redirect_to school_path(school.id)
    end
  end
end
