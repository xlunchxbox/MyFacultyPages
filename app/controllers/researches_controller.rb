class ResearchesController < ApplicationController
  before_filter :authorize
  before_action :set_research, only: [:show, :edit, :update, :destroy]

  def new
    @title = 'Add research'
    @research = Research.new
  end

  def edit
    @title = 'Edit research'
  end

  def create
    @research = Research.new(research_params)
    @research.faculty_member_id = current_faculty.id unless current_faculty.nil?

    if @research.save
      flash[:success] = 'Research successfully created.'
      redirect_to researches_faculty_member_path(current_faculty)
    else
      @title = 'Add research'
      render action: 'new' 
    end
  end

  def update
    if @research.update(research_params)
      flash[:success] = 'Research successfully updated.'
      redirect_to researches_faculty_member_path(current_faculty)
    else
      @title = 'Edit research'
      render action: 'edit'
    end
  end

  def destroy
    @research.destroy
    flash[:success] = 'Research removed.'
    redirect_to researches_faculty_member_path(current_faculty)
  end

  private
    def set_research
      @research = Research.find(params[:id])
    end

    def research_params
      params.require(:research).permit(:topic, :start_date, :end_date, :summary, :faculty_member_id)
    end
end
