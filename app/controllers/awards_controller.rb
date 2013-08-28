class AwardsController < ApplicationController
  before_filter :authorize
  before_action :set_award, only: [:show, :edit, :update, :destroy]

  def new
    @title = 'Add award'
    @award = Award.new
  end

  def edit
    @title = 'Edit award'
  end

  def create
    @award = Award.new(award_params)
    @award.faculty_member_id = current_faculty.id

    if @award.save
    	flash[:success] = 'Award successfully created.'
      redirect_to curriculum_vitae_faculty_member_path(current_faculty) 
    else
      @title = 'Add award'
      render action: 'new'
    end
  end

  def update
    if @award.update(award_params)
    	flash[:success] = 'Award successfully updated.'
      redirect_to curriculum_vitae_faculty_member_path(current_faculty)
    else
      @title = 'Edit award'
      render action: 'edit'
    end
  end

  def destroy
    @award.destroy
    flash[:success] = 'Award removed.'
    redirect_to curriculum_vitae_faculty_member_path(current_faculty)
  end

  private
    def set_award
      @award = Award.find(params[:id])
    end

    def award_params
      params.require(:award).permit(:title, :issuer, :issue_date, :summary, :faculty_member_id)
    end
end
