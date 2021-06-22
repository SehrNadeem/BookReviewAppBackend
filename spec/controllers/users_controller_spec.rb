require "rails_helper"

RSpec.describe UsersController, :type => :controller do
  describe "after create action" do
    it "should exist in database" do
      expect {
        post :create, 
        params: { username: 'sehr', password: '123', first_name: 'Sehr', last_name: 'Nadeem', email: 'sehr@123.com' }
      }.to change(User, :count).by(1)

    end
  end
end