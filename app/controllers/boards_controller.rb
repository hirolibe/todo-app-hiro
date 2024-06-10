class BoardsController < ApplicationController aaa
  before_action :set_board, only: [:show]
  before_action :authenticate_user!, only: [:new, :create]#, :edit, :update, :destroy]

  def index
    @boards = Board.all
  end

  def show
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

  private

  def board_params
    params.require(:board).permit(:name, :description)
  end

  def set_board
    @board = Board.find(params[:id])
  end

end