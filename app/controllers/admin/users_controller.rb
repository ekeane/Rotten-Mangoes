class Admin::UsersController < ApplicationController

	def index
	  #@users = User.find_by(deleted: false)
	 	@users = User.where("deleted='f'")   #soft delete 
	  #deleted: :false)  #for email
	end

	def new
		  @user = User.new
	end


	#----- for page displaying all current users ---------#

	def show
		if current_admin?
	    @users = Users.all.count
		end
	end


	def destroy
	    @user = User.find(params[:id])
	    puts params[:id]
	    #@user.destroy
	    @user.deleted = true
	    @user.save
	    #@user.update(deleted: :true)
	    redirect_to admin_users_path
	end
end
