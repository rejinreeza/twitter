class SessionsController < ApplicationController
	def new
	end
	def create
		user = User.find_by(username: params[:username])
		if user && user.authenticate_user(params[:password])
			session[:user_id] = user.id 
			redirect_to user
		else
			render :new, :notice => "wrong username or password"
		end
	end
	
	def destroy
	  session[:user_id] = nil
	  redirect_to root_url, :notice => "Logged out!"
	end
end
