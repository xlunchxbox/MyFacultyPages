class CoursesController < ApplicationController
  before_filter :authorize
	before_action :set_course, only: [:show, :edit, :update, :destroy]

  def new
    @title = 'Add course'
    @course = Course.new
  end

  def edit
    @title = 'Edit course'
  end

  def create
    @course = Course.new(course_params)
    @course.faculty_member_id = current_faculty.id unless current_faculty.nil?

    if @course.save
      flash[:success] = 'Course successfully created.'
      redirect_to courses_faculty_member_path(current_faculty)
    else
      @title = 'Add course'
      render action: 'new'
    end
  end

  def update
    if @course.update(course_params)
      flash[:success] = 'Course was successfully updated.'
      redirect_to courses_faculty_member_path(current_faculty)
    else
      @title = 'Edit course'
      render action: 'edit'
    end
  end

  def destroy
    @course.destroy
    flash[:success] = 'Course removed.'
    redirect_to courses_faculty_member_path(current_faculty)
  end

  private
    def set_course
      @course = Course.find(params[:id])
    end

    def course_params
      params.require(:course).permit(:dept_code, :course_no, :name, :term, :year, :summary, :faculty_member_id)
    end
end
