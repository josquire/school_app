class ClassroomsController < ApplicationController
  before_action :classroom, except: [:index, :new, :create]
  before_action :school
  def index
    @classrooms = @school.classrooms.all
  end

  def show
  end

  def new
    @classroom = Classroom.new
  end

  def create
    @classroom = @school.classrooms.new(classroom_params)
    if @classroom.save
      redirect_to school_path(@school)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @classroom.update(classroom_params)
      redirect_to school_classroom_path(@school, @classroom)
    else
      render :edit
    end
  end

  def destroy
    school_id = @classroom.school_id
    @classroom.destroy
    redirect_to school_classroom_path(@school, @classroom)
  end

  private

  def classroom
    @classroom = Classroom.find(params[:id])
  end

  def classroom_params
    params.require(:classroom).permit(:teacher, :grade, :number_students, :school_id)
  end

  def school
    @school = School.find(params[:school_id])
  end

end
