class BooksController < ApplicationController
  def index
    books = Book.all

    render json: {
      books: books
    }
  end
  
  def create
    book = Book.new(book_params)
    if book.save!
      render json: {
        status: "success",
        book: book
      }
    else
      redner json: {
        status: "failed"
      }
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :book_img)
  end

end
