# frozen_string_literal: true

class BooksController < ApplicationController
  
  def index
    books = Book.all.includes(:user)
    posted_by = [];
    books.each_with_index do |book, index| 
      posted_by[index] = book.user.username
    end

    books = Book.paginate(books, params[:page])
    render json: { books: books, posted_by: posted_by }
  end

  def create
    book = Book.create(book_params)
    if book.valid?
      render json: book
    else
      render json: { errors: book.errors.full_messages }, status: :not_acceptable
    end
  end

  def show
    book = Book.find(params[:id])
    render json: { book: book } 
  end

  def search
    books = Book.includes(:user).where('title LIKE ?', "%#{params[:q]}%")
    posted_by = [];
    books.each_with_index do |book, index| 
      posted_by[index] = book.user.username
    end
    # binding.pry
    books = Book.paginate(books, params[:page])
    render json: { books: books, posted_by: posted_by }
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    if book.destroyed?
      render json: { delete_success: true }
    else
      render json: { errors: book.errors.full_messages }, status: :not_acceptable
    end
  end

  private

  def book_params
    params.permit(:title, :author, :short_description, :cover_photo).merge(user_id: @current_user.id)
  end
end
