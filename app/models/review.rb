# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  after_save :update_average_rating

  def update_average_rating
    book = Book.where(id: book_id).first
    rating_sum = book.average_rating * book.total_reviews
    new_count = book.total_reviews + 1
    new_average_rating = (rating_sum + rating) / new_count
    book.update(total_reviews: new_count, average_rating: new_average_rating)
  end

end
