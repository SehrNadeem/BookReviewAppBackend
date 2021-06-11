# frozen_string_literal: true

class BooksController < ApplicationController
  
  def index
    books = Book.all.includes(:user)
    posted_by = [];
    books.each_with_index do |book, index| 
      posted_by[index] = book.user.username
    end
    if params[:page]
      page_info = params[:page].split(':')

      if page_info[1].eql?("next")
        pagination_result = RailsCursorPagination::Paginator.new(books, first: 3, after: page_info[0]).fetch
      else
        pagination_result = RailsCursorPagination::Paginator.new(books, last: 3, before: page_info[0]).fetch
      end

    else
      pagination_result = RailsCursorPagination::Paginator.new(books, first: 3).fetch
    end

    books = pagination_result[:page]
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

  private

  def book_params
    params.permit(:title, :author, :short_description, :cover_photo).merge(user_id: @current_user.id)
  end
end
