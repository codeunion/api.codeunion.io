require File.expand_path("../config/application", __FILE__)

if Rails.env.development?
  require "rubocop/rake_task"
  RuboCop::RakeTask.new
end

Rails.application.load_tasks
