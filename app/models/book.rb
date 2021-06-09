# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :user
  mount_uploader :cover_photo, ImageUploader
  has_many :reviews

end
