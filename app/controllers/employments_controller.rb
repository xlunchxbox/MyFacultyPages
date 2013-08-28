class EmploymentsController < ApplicationController
  before_filter :authorize
  before_action :set_employment, only: [:show, :edit, :update, :destroy]

  def new
    @title = 'Add employment'
    @employment = Employment.new
  end

  def edit
    @title = 'Edit employment'
  end

  def create
    @employment = Employment.new(employment_params)
    @employment.faculty_member_id = current_faculty.id

    if @employment.save
    	flash[:success] = 'Employment successfully added.'
      redirect_to curriculum_vitae_faculty_member_path(current_faculty)
    else
      @title = 'Add employment'
      render action: 'new' 
    end
  end

  def update
    if @employment.update(employment_params)
    	flash[:success] = 'Employment successfully updated.'
      redirect_to curriculum_vitae_faculty_member_path(current_faculty)
    else
      @title = 'Edit employment'
      render action: 'edit' 
    end
  end

  def destroy
    @employment.destroy
    flash[:success] = 'Employment removed.'
    redirect_to curriculum_vitae_faculty_member_path(current_faculty)
  end

  private
    def set_employment
      @employment = Employment.find(params[:id])
    end

    def employment_params
      params.require(:employment).permit(:company, :position, :start_date, :end_date, :summary, :faculty_member_id)
    end
end
