class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.create! book_params
    logger.debug(book_params[:cover])
    @book.cover.purge
    @book.cover.attach(params[:book][:cover])
    redirect_to book_path(@book)
  end

  def book_params
      params.require(:book).permit(:title, :author, :describe, :cover)
  end
end
