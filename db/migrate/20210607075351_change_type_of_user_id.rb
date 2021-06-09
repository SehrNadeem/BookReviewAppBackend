# frozen_string_literal: true

class ChangeTypeOfUserId < ActiveRecord::Migration[6.1]
  def change
    change_column :books, :user_id, :bigint
  end
end
