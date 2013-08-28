class SessionsController < ApplicationController
  def new
    redirect_to(current_faculty) if signed_in?
    @title = 'Sign in'
  end

  def create
    faculty = FacultyMember.find_by(university_id: params[:session][:university_id])
    if faculty && faculty.authenticate(params[:session][:password])
      sign_in faculty
      flash[:success] = 'You are now signed in.'
      redirect_to faculty
    else
      @title = 'Sign in'
      flash.now[:error] = 'Invalid ID/password combination'
      render 'new'
    end
  end
  
  def destroy
    sign_out
    flash[:success] = 'You have signed out.'
    redirect_to root_path
  end
end
