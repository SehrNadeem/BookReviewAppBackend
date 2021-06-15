require 'resque/tasks'
require 'resque/scheduler/tasks'

task "resque:setup" => :environment do
  require 'resque'
  require 'resque-scheduler'

  ENV['QUEUE'] = '*'
  Resque.redis = 'localhost:6379' unless Rails.env == 'production'
end