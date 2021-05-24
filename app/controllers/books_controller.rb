class BooksController < ApplicationController
  def index
    @books = Book.all
  end
  
  def create
    @book = Book.new(book_params)
    if @book.save!
      redirect_to books_url
    else
      render new_book_path
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :book_img)
  end

end
