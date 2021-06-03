# frozen_string_literal: true

class User < ApplicationRecord
  has_many :reviews
  has_many :books
  has_secure_password
end
