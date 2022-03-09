class BooksController < ApplicationController
  before_action :currect_user, only: [:edit, :update]
  def new
    @book = Book.new
  end

  def create
    @books = Book.new(book_params)
    @books.user_id = current_user.id

    if @books.save
      flash[:notice] = 'You have created book successfully.'
      redirect_to book_path(@books.id)
    else
      
      @user = current_user
      @book = Book.all
      render :index
    end
  end

  def index
    @book = Book.all
    @books = Book.new
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    flash[:notice] = "Book was successfully update."
      @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    flash[:notice] = "Book was successfully destroyed."
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def currect_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end
end
