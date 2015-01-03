require 'resource_loader'

namespace :resources do
  desc "Creates a project, example, or resource"
  task :create, [:category, :url] => :environment  do |t, arguments|
    output = ResourceLoader::CLI.new(arguments[:url], arguments[:category], Resource).run
    puts output
  end
end
