require 'resque/server'
require 'resque/scheduler/server'
require 'active_scheduler'

yaml_schedule    = YAML.load_file("#{Rails.root}/config/resque_schedule.yml") || {}
wrapped_schedule = ActiveScheduler::ResqueWrapper.wrap yaml_schedule
Resque.schedule  = wrapped_schedule