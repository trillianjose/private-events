class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
      redirect_to :root
    else
      render 'new'
    end
  end

  def show
    @userowner = current_user.events_as_owner.order(schedule: :desc)
    @userassistent = current_user.events_as_assistent.order(schedule: :desc)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
