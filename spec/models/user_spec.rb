require "rails_helper"

RSpec.describe 'User', type: :model  do
  context 'after record creation' do
    it 'should exist in database' do
      expect { 
        User.create!(username: 'rspec test', password:'123', first_name: 'Test', last_name: 'Cases') 
      }.to change { User.count }
    end
  end
end