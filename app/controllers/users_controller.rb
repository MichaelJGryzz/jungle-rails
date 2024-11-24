class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Welcome #{@user.first_name}! Your account has been created."
    else
      if @user.errors.details[:email]&.any? { |e| e[:error] == :taken }
        flash.now[:alert] = 'Email has already been taken! Please use a different email.'
      else
        flash.now[:alert] = 'There was an error creating your account.'
      end
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
