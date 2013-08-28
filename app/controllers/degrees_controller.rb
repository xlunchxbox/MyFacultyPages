class DegreesController < ApplicationController
  before_filter :authorize
  before_action :set_degree, only: [:show, :edit, :update, :destroy]

  def new
    @title = 'Add degree'
    @degree = Degree.new
  end

  def edit
    @title = 'Edit degree'
  end

  def create
    @degree = Degree.new(degree_params)
    @degree.faculty_member_id = current_faculty.id unless current_faculty.nil?

    if @degree.save
    	flash[:success] = 'Degree successfully created.'
      redirect_to curriculum_vitae_faculty_member_path(current_faculty)
    else
      @title = 'Add degree'
      render action: 'new'
    end
  end

  def update
    if @degree.update(degree_params)
    	flash[:success] = 'Degree successfully updated.'
      redirect_to curriculum_vitae_faculty_member_path(current_faculty)
    else
      @title = 'Edit degree'
      render action: 'edit'
    end
  end

  def destroy
    @degree.destroy
    flash[:success] = 'Degree removed.'
    redirect_to curriculum_vitae_faculty_member_path(current_faculty)
  end

  private

    def set_degree
      @degree = Degree.find(params[:id])
    end

    def degree_params
      params.require(:degree).permit(:title, :field_of_study, :institution, :issue_date, :faculty_member_id)
    end
end
