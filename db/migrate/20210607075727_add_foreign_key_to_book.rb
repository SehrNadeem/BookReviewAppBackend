# frozen_string_literal: true

class AddForeignKeyToBook < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :books, :users
  end
end
