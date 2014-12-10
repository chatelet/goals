class UserCommentsController < ApplicationController
  def new
    @user_comment = UserComment.new(:user_id => params[:id])
    render :new
  end

  def create
    @user_comment = UserComment.new(user_comment_params)
    @user_comment.author_id = current_user.id

    if @user_comment.save
      redirect_to user_url(@user_comment.user_id)
    else
      flash.now[:errors] = @user_comment.errors.full_messages
      render :new
    end

  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def edit
    @user_comment = UserComment.find(params[:id])
    render :edit
  end

  def update
    @user_comment = UserComment.find(params[:id])

    if @user_comment.update(user_comment_params)
      redirect_to user_url(@user_comment.user_id)
    else
      flash.now[:errors] = @user_comment.errors.full_messages
      render :edit
    end

  end

  def destroy
    @user_comment = UserComment.find(params[:id])
    user_id = @user_comment.user_id
    @user_comment.destroy
    redirect_to user_url(user_id)
  end

  private

  def user_comment_params
    params.require(:user_comment).permit(:body, :user_id)
  end
end
