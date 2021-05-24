class BooksController < ApplicationController
  def index
    books = Book.all

    render json: {
      books: books
    }
  end

  def show
    book = Book.find(params[:id])
    render json: {
      book: book.title,
      avatar: url_for(book.book_img)
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
    params.permit(:title, :book_img)
  end

end
