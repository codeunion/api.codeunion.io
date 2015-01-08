require 'resource_loader'
require 'manifest_loader'

namespace :resources do
  desc "Creates a project, example, or resource"
  task :create, [:category, :url] => :environment  do |t, arguments|
    output = ResourceLoader::CLI.new(arguments[:url], arguments[:category], Resource).run
    puts output
  end

  desc "Refreshes all the resources in the manifest and database"
  task :refresh => :environment do
    extras = Resource.all.map(&:as_json)
    loader = ManifestLoader.new(extra_manifests: extras)
    loader.manifests.each do |m|
      begin
        puts "Loading #{m['url']}"
        ResourceLoader.new(m['url'], m['category'], Resource).retrieve_and_store
      rescue ResourceLoader::ResourceNotPublic => e
        puts "#{m['url']} was not a public resource."
      end
    end
  end
end
