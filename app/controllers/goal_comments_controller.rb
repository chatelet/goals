class GoalCommentsController < ApplicationController

  def new
    @goal_comment = GoalComment.new(:goal_id => params[:goal_id])
    render :new
  end

  def create
    @goal_comment = GoalComment.new(goal_comment_params)
    @goal_comment.author_id = current_user.id

    if @goal_comment.save
      redirect_to goal_url(@goal_comment.goal_id)
    else
      flash.now[:errors] = @goal_comment.errors.full_messages
      render :new
    end

  end

  def edit
    @goal_comment = GoalComment.find(params[:id])
    render :edit
  end

  def update
    @goal_comment = GoalComment.find(params[:id])

    if @goal_comment.update(goal_comment_params)
      redirect_to goal_url(@goal_comment.goal_id)
    else
      flash.now[:errors] = @goal_comment.errors.full_messages
      render :edit
    end

  end

  def destroy
    @goal_comment = GoalComment.find(params[:id])
    goal_id = @goal_comment.goal_id
    @goal_comment.destroy
    redirect_to goal_url(goal_id)
  end

  private

  def goal_comment_params
    params.require(:goal_comment).permit(:body)
  end
end
