class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    redirect_to book_path(@book), notice: "You have created book successfully."
    else
    @books = Book.all
    render :index
    end
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user

  end

  def show
    @book = Book.find(params[:id])
    @new_book = Book.new
    @user = @book.user
    @book_comment = BookComment.new
    @book_comments = @book.book_comments
  end

  def edit
    @book = Book.find(params[:id])

  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    redirect_to book_path(@book) , notice:'You have updated book successfully.'
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def new_book
    @new_book = Book.new
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def user_params
    params.require(:user).permit(:name)
  end

  def correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
        redirect_to books_path
    end
  end


end