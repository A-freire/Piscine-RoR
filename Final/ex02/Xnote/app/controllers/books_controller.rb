class BooksController < ApplicationController
  before_action :set_book, only: [:edit, :update, :destroy]
  before_action :set_books, only: :index

  def index
    @book = Book.new
  end

  def new
    @book = Book.new

    respond_to do |format|
      format.html { redirect_to books_path }
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.html { redirect_to books_path }
      format.js
    end
  end

  def create
    @book = Book.new(book_params)
    @saved = @book.save
    @books = Book.ordered

    respond_to do |format|
      if @saved
        format.html { redirect_to books_path, notice: "Book was successfully created." }
        format.js
      else
        format.html { render :index, status: :unprocessable_entity }
        format.js { render :create, status: :unprocessable_entity }
      end
    end
  end

  def update
    @saved = @book.update(book_params)
    @books = Book.ordered

    respond_to do |format|
      if @saved
        format.html { redirect_to books_path, notice: "Book was successfully updated." }
        format.js
      else
        format.html { render :index, status: :unprocessable_entity }
        format.js { render :update, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @book.destroy
    @books = Book.ordered

    respond_to do |format|
      format.html { redirect_to books_url, notice: "Book was successfully destroyed." }
      format.js
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def set_books
    @books = Book.ordered
  end

  def book_params
    params.require(:book).permit(:name)
  end
end
