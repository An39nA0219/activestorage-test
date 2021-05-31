class BooksController < ApplicationController
  def index
    books = Book.all
    books = books.map{|book| book.attributes}
    books.each do |book|
      b = Book.find(book["id"])
      if b.book_img.attached?
        book["img"] = url_for(b.book_img)
      else
        book["img"] = nil
      end
    end

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
