class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :current_admin?

  protected

		def restrict_access
	    if !current_user
	      flash[:alert] = "You must log in."
	      redirect_to new_session_path
	    end
	  end

	  def current_user
	    @current_user ||= User.find(session[:user_id]) if session[:user_id]
	  end

	  def current_admin?
	  	current_user.admin?  
	  end 

	  def authorize
	  	unless current_admin?
	  		flash[:error] = "your forbidden buddy"
	  		redirect_to movie_path
	  		false
	  	end
		end 
end
