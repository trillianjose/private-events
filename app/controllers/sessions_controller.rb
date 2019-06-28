class SessionsController < ApplicationController
  def create
    @user = User.find_by(email: params[:session][:email].downcase)

    if @user
      log_in @user
      user_chose_remember_me?

      redirect_to :root
    else
      flash.now[:danger] = 'Invalid email'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?

    redirect_to :root
  end

  private

  def user_chose_remember_me?
    params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
  end
end
