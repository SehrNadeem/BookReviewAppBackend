require "rails_helper"

RSpec.describe 'Review', type: :model  do
  context 'after review creation' do
    let(:user) {
      User.create!(username: 'sehr', email: 'sehr@123.com', password: '123', first_name: 'Sehr', last_name: 'Nadeem')
    } 
    let(:book) {
      user.books.create!(title: 'Book 1', author: 'User 1', average_rating: 0, total_reviews: 0)
    }

    it 'should correctly update average rating of book' do
      expect {
        book.reviews.create!(user_id: user.id, rating: 5, details: 'testing average rating calucation')
      }.to change { book.reload.average_rating }.to 5

      expect {
        book.reviews.reload.create!(user_id: user.id, rating: 1, details: 'testing average rating calucation') 
      }.to change { book.reload.average_rating }.to 3
    end

  end
end