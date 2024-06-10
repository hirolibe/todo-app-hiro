class BoardsController < ApplicationController
  before_action :set_board, only: [:edit, :update]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @boards = Board.all
  end

  def show
    @board = Board.find(params[:id])
  end

  def new
    @board = current_user.boards.build
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to board_path(@board), notice: 'ボードを作成しました'
    else
      flash.now[:error] = 'ボードの作成に失敗しました'
      render :new
    end
  end

  def edit
  end

  def update
    if @board.update(board_params)
      redirect_to board_path(@board), notice: 'ボードを更新しました'
    else
      flash.now[:error] = 'ボードの更新に失敗しました'
      render :edit
    end
  end

  def destroy
    board = current_user.boards.find(params[:id])
    board.destroy!
    redirect_to root_path, notice: '削除に成功しました'
  end

  private

  def board_params
    params.require(:board).permit(:name, :description)
  end

  def set_board
    @board = current_user.boards.find(params[:id])
  end

end