class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]

  def new
    task = Task.find(params[:task_id])
    @comment = task.comments.build
  end

  def create
    task = Task.find(params[:task_id])
    @comment = task.comments.build(comment_params)
    if @comment.save
      redirect_to board_task_path(task.board, task), notice: 'ボードを作成しました'
    else
      flash.now[:error] = 'ボードの作成に失敗しました'
      render :new
    end
  end

  def destroy
    comment = current_user.comments.find(params[:id])
    comment.destroy!
    redirect_to board_task_path(comment.task), notice: '削除に成功しました'
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id)
  end

end