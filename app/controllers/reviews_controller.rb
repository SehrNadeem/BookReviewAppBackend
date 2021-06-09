# frozen_string_literal: true

class ReviewsController < ApplicationController
  def index
    reviews = Review.all
    render json: reviews
  end

  def create
    review = Review.create(review_params)
    if review.valid?
      render json: review
    else
      render json: { errors: review.errors.full_messages }, status: :not_acceptable
    end
  end

  def show
    review = Review.find(params[:id])
    render json: review
  end

  def get_reviews_for_book
    reviews = Review.where(book_id: params[:id])
    posted_by = []
    reviews.each_with_index do |review, index|
      posted_by[index] = User.find(review.user_id).username
    end
    render json: { reviews: reviews, posted_by: posted_by }
  end

  private

  def review_params
    params.permit(:details, :rating, :book_id).merge(user_id: @current_user.id)
  end
end
