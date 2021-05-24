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
      img: url_for(book.book_img)
    }
  end
  
  def create
    book = Book.new(book_params)
    if book.save!
      book.parse_base64(book_img_params[:book_img])
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
    params.permit(:title)
  end

  def book_img_params
    params.permit(:book_img)
  end

end
