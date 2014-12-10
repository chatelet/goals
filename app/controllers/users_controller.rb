class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(username: user_params[:username])
    @user.password = user_params[:password]
    if @user.save
      redirect_to goals_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @comments = UserComment.where( user_id: @user.id).includes(:author)
    render :show
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
