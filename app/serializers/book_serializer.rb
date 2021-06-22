class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :author, :short_description, :total_reviews, :average_rating, :cover_photo

  has_one :user
end
