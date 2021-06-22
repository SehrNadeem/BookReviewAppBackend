# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :user
  mount_uploader :cover_photo, ImageUploader
  has_many :reviews


  def self.paginate(books, pagination_key)
    if pagination_key
      page_info = pagination_key.split(':')

      if page_info[1].eql?("next")
        pagination_result = RailsCursorPagination::Paginator.new(books, first: 3, after: page_info[0]).fetch
      else
        pagination_result = RailsCursorPagination::Paginator.new(books, last: 3, before: page_info[0]).fetch
      end

    else
      pagination_result = RailsCursorPagination::Paginator.new(books, first: 3).fetch
    end
    books = pagination_result[:page]

  end

end
