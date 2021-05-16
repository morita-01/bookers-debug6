class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)#,notice: "You have created book successfully."
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end
  
  def edit
    @book = Book.find(params[:id])
    @user = @book.user
    if @user != current_user
      redirect_to books_path
    end
  end

  def update
    book = Book.find(params[:id])
    book.user_id = current_user.id
    if book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(book)#,notice: "You have updated book successfully."
    else
      @book = book
      render :edit
    end
  end

  def show
    @book = Book.find(params[:id])
    @newbook = Book.new
    @user = @book.user
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end