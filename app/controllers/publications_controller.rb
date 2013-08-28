class PublicationsController < ApplicationController
  before_filter :authorize
  before_action :set_publication, only: [:show, :edit, :update, :destroy]

  def new
    @title = 'Add publication'
    @publication = Publication.new
  end

  def edit
    @title = 'Edit publication'
  end

  def create
    @publication = Publication.new(publication_params)
    @publication.faculty_member_id = current_faculty.id unless current_faculty.nil?
    
    if @publication.save
      flash[:success] = 'Publication successfully created.'
      redirect_to publications_faculty_member_path(current_faculty)
    else
      @title = 'Add publication'
      render action: 'new'
    end
  end

  def update
    if @publication.update(publication_params)
      flash[:success] = 'Publication updated successfully.'
      redirect_to publications_faculty_member_path(current_faculty)
    else
      @title = 'Edit publication'
      render action: 'edit'
    end
  end

  def destroy
    @publication.destroy
    flash[:success] = 'Publication removed.'
    redirect_to publications_faculty_member_path(current_faculty)
  end

  private
    def set_publication
      @publication = Publication.find(params[:id])
    end

    def publication_params
      params.require(:publication).permit(:title, :summary, :faculty_member_id, :year, :image_url)
    end
end
