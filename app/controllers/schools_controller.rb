class SchoolsController < ApplicationController
  before_action :school, except: [:index, :new, :create]

  def index
    @schools = School.all
  end

  def show
    @classrooms = @school.classrooms
  end

  def new
    @school = School.new
  end

  def create
    @school = School.new(school_params)
    if @school.save
      redirect_to school_path(@school), success: "School #{@school.name} created!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @school.update(school_params)
      redirect_to school_path(@school), success: "School #{@school.name} updated!"
    else
      render :edit
    end
  end

  def destroy
    name = @school.name
    @school.destroy
    redirect_to schools_path, success: "#{name} School has been destroyed"
  end

private


  def school
    @school = School.find(params[:id])
  end

  def school_params
    params.require(:school).permit(:name, :level, :student_body)
  end

end
