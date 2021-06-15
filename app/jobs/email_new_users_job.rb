class EmailNewUsersJob < ApplicationJob
  queue_as :mail

  def perform()
    users = User.where('created_at > ?', 1.minute.ago)
    users.each do |user|
      UserMailer.with(user: user).welcome_email.deliver
    end
    
  end
end
