class SessionsController < ApplicationController

  def new
    # Render the login form
  end

  def create
    # Authenticate user by email and password
    if user = User.authenticate_with_credentials(params[:email], params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Logged in successfully. Welcome back #{user.first_name}!"
    else
      flash.now[:alert] = 'Invalid email or password'
      render :new
    end
  end

  def destroy
    # Clear session
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out successfully.'
  end

end
