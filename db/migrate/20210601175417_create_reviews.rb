class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.string :details
      t.integer :rating
      t.integer :book_id
      t.integer :user_id

      t.timestamps
    end
  end
end
