class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper

  protected
  
    def authorize
      unless signed_in?
        flash[:notice] = 'You do not have permission to visit this page. Please sign in.'
        redirect_to signin_path
      end
    end

    def correct_faculty
      @faculty = FacultyMember.find(params[:id])
      if signed_in? && !current_faculty?(@faculty)
        flash[:notice] = 'Please log out before leaving page.'
        redirect_to current_faculty
      end
    end
end
