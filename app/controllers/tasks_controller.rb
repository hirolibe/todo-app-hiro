class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @tasks = current_user.tasks
  end

  def show
    @task = Task.find(params[:id])
    @comments = @task.comments
  end

  def new
    board = Board.find(params[:board_id])
    @task = board.tasks.build
  end

  def create
    board = Board.find(params[:board_id])
    @task = board.tasks.build(task_params)
    if @task.save
      redirect_to board_task_path(id: @task.id), notice: 'ボードを作成しました'
    else
      flash.now[:error] = 'ボードの作成に失敗しました'
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to board_task_path(@task), notice: 'ボードを更新しました'
    else
      flash.now[:error] = 'ボードの更新に失敗しました'
      render :edit
    end
  end

  def destroy
    task = current_user.tasks.find(params[:id])
    task.destroy!
    redirect_to board_path(task.board), notice: '削除に成功しました'
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :deadline, :user_id)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

end