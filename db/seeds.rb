require "rake"

Rake::Task.clear
CodeunionApi::Application.load_tasks
Rake::Task["resources:refresh"].invoke
